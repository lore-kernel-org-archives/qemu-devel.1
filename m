Received: from eggs.gnu.org ([2001:4830:134:3::10]:49980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYY7v-0003Kz-Dn
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYY7t-0007n8-Mf
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:42:27 -0400
References: <20180628132211.8795-1-rjones@redhat.com>
	<20180628132211.8795-2-rjones@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf457707-eaab-16f9-d1c9-3a3f6423958e@redhat.com>
Date: Thu, 28 Jun 2018 09:42:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180628132211.8795-2-rjones@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] crypto: Implement TLS Pre-Shared Keys
 (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-block@nongnu.org

On 06/28/2018 08:22 AM, Richard W.M. Jones wrote:

In the subject line: most commit summaries don't have a trailing '.'.

> Pre-Shared Keys (PSK) is a simpler mechanism for enabling TLS
> connections than using certificates.  It requires only a simple secret
> key:
> 
>    $ mkdir -m 0700 /tmp/keys
>    $ psktool -u rjones -p /tmp/keys/keys.psk
>    $ cat /tmp/keys/keys.psk
>    rjones:d543770c15ad93d76443fb56f501a31969235f47e999720ae8d2336f6a13fcbc
> 
> The key can be secretly shared between clients and servers.  Clients
> must specify the directory containing the "keys.psk" file and a
> username (defaults to "qemu").  Servers must specify only the
> directory.
> 
> Example NBD client:
> 
>    $ qemu-img info \
>      --object tls-creds-psk,id=tls0,dir=/tmp/keys,username=rjones,endpoint=client \
>      --image-opts \
>      file.driver=nbd,file.host=localhost,file.port=10809,file.tls-creds=tls0,file.export=/

Not your problem, but it would be nice if someday our --object command 
line arguments also had QMP counterparts to better document what 
key/value pairs each particular object type permits/requires (yeah, you 
can do it via QMP now, but object-add is an untyped command that just 
passes a raw dict through rather than benefitting from type-safe parsing).

> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>   crypto/Makefile.objs           |   1 +
>   crypto/tlscredspsk.c           | 300 +++++++++++++++++++++++++++++++++
>   crypto/tlssession.c            |  50 +++++-
>   crypto/trace-events            |   3 +
>   include/crypto/tlscredspsk.h   | 106 ++++++++++++
>   qemu-doc.texi                  |  37 ++++
>   qemu-options.hx                |  24 +++
>   tests/Makefile.include         |   4 +-
>   tests/crypto-tls-psk-helpers.c |  50 ++++++
>   tests/crypto-tls-psk-helpers.h |  29 ++++
>   tests/test-crypto-tlssession.c | 185 +++++++++++++++++---
>   11 files changed, 763 insertions(+), 26 deletions(-)

> +static int
> +lookup_key(const char *pskfile, const char *username, gnutls_datum_t *key,
> +           Error **errp)
> +{
> +    FILE *fp;
> +    char line[1024]; /* Maximum key length in psktool is 512 bytes. */

That's true for a valid file produced by psktool, but...

> +    size_t ulen = strlen(username);
> +    size_t len;
> +
> +    fp = fopen(pskfile, "r");

Do we want to consider the use of qemu_open() to allow qemu to read from 
a pre-opened fd, rather than requiring the ability to open() from the 
file system? (May matter if we want to combine crypto usage with a 
locked-down qemu that has seccomp or selinux preventing bare open).  But 
that gets tricky since there may be more than one file within the 
directory to open, and the existing x509 certificate handling is also 
impacted by such a design decision, so that's more a question for Dan 
and not necessarily a problem in this patch.

> +    if (fp == NULL) {
> +        error_setg_errno(errp, errno, "Cannot open PSK file %s", pskfile);
> +        return -1;
> +    }
> +    while (fgets(line, sizeof line, fp) != NULL) {
> +        if (strncmp(line, username, ulen) == 0 && line[ulen] == ':') {

...can't this misbehave if the user accidentally points to some other 
file (rather than one produced by psktool)?  I'm wondering if a 
getline() loop would be smarter than trying to use a fixed-length buffer.

> +            len = strlen(line);
> +            if (len > 0 && line[len - 1] == '\n') {
> +                len--;
> +                line[len] = '\0';
> +            }
> +            key->data = (unsigned char *) g_strdup(&line[ulen + 1]);
> +            key->size = len - ulen - 1;
> +            fclose(fp);
> +            return 0;
> +        }
> +    }
> +    fclose(fp);
> +    error_setg(errp, "Username %s not found in PSK file %s",
> +               username, pskfile);
> +    return -1;
> +}
> +
...

> +
> +static void
> +qcrypto_tls_creds_psk_prop_set_username(Object *obj,
> +                                        const char *value,
> +                                        Error **errp G_GNUC_UNUSED)
> +{
> +    QCryptoTLSCredsPSK *creds = QCRYPTO_TLS_CREDS_PSK(obj);
> +
> +    creds->username = g_strdup(value);

Does it make sense to forbid this operation on servers (since it only 
makes sense for clients)?


> +/**
> + * QCryptoTLSCredsPSK:
> + *
> + * The QCryptoTLSCredsPSK object provides a representation
> + * of the Pre-Shared Key credential used to perform a TLS handshake.
> + *
> + * This is a user creatable object, which can be instantiated
> + * via object_new_propv():
> + *
> + * <example>
> + *   <title>Creating TLS-PSK credential objects in code</title>
> + *   <programlisting>
> + *   Object *obj;
> + *   Error *err = NULL;
> + *   obj = object_new_propv(TYPE_QCRYPTO_TLS_CREDS_PSK,
> + *                          "tlscreds0",
> + *                          &err,
> + *                          "dir", "/path/to/dir",
> + *                          "endpoint", "client",
> + *                          NULL);
> + *   </programlisting>
> + * </example>
> + *
> + * Or via QMP:
> + *
> + * <example>
> + *   <title>Creating TLS-PSK credential objects via QMP</title>
> + *   <programlisting>
> + *    {
> + *       "execute": "object-add", "arguments": {
> + *          "id": "tlscreds0",
> + *          "qom-type": "tls-creds-psk",
> + *          "props": {
> + *             "dir": "/path/to/dir",
> + *             "endpoint": "client",
> + *          }

No trailing comma after "client"

> + *       }
> + *    }
> + *   </programlisting>
> + * </example>
> + *
> + * Or via the CLI:
> + *
> + * <example>
> + *   <title>Creating TLS-PSK credential objects via CLI</title>
> + *   <programlisting>
> + *  qemu-system-x86_64 -object tls-creds-psk,id=tlscreds0,\

I'd use '--object' here, since only that form will also apply to qemu-nbd.

> + *          endpoint=client,dir=/path/to/dir[,username=qemu]
> + *   </programlisting>
> + * </example>
> + *
> + * The PSK file can be created and managed using psktool.
> + */
> +

> +++ b/qemu-options.hx
> @@ -4099,6 +4099,30 @@ expensive operation that consumes random pool entropy, so it is
>   recommended that a persistent set of parameters be generated
>   upfront and saved.
>   
> +@item -object tls-creds-psk,id=@var{id},endpoint=@var{endpoint},dir=@var{/path/to/keys/dir}[,username=@var{username}]

Another candidate for spelling as --object.  (Yeah, I know, this file 
has a lot of pre-existing examples that should also be fixed)

> +
> +Creates a TLS Pre-Shared Keys (PSK) credentials object, which can be used to provide
> +TLS support on network backends. The @option{id} parameter is a unique
> +ID which network backends will use to access the credentials. The
> +@option{endpoint} is either @option{server} or @option{client} depending
> +on whether the QEMU network backend that uses the credentials will be
> +acting as a client or as a server. For clients only, @option{username}
> +is the username which will be sent to the server.  If omitted
> +it defaults to ``qemu''.
> +
> +The @var{dir} parameter tells QEMU where to find the keys file.
> +It is called ``@var{dir}/keys.psk'' and contains ``username:key''
> +pairs.  This file can most easily be created using the GnuTLS
> +@code{psktool} program.
> +
> +For server endpoints, @var{dir} may also contain a file
> +@var{dh-params.pem} providing diffie-hellman parameters to use
> +for the TLS server. If the file is missing, QEMU will generate
> +a set of DH parameters at startup. This is a computationally
> +expensive operation that consumes random pool entropy, so it is
> +recommended that a persistent set of parameters be generated
> +upfront and saved.

s/upfront/up front/

> +++ b/tests/crypto-tls-psk-helpers.c

Otherwise, I'm not spotting problems, but as it touches crypto, I'd also 
get Dan's review.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
