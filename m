Received: from eggs.gnu.org ([209.51.188.92]:44983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwUU5-0007mb-L3
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwUU4-00005M-8Y
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:12:33 -0500
References: <20190220145819.30969-1-berrange@redhat.com>
	<20190220145819.30969-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <52d7b4c8-4764-630b-a5ba-bc8d37359081@redhat.com>
Date: Wed, 20 Feb 2019 10:11:40 -0600
MIME-Version: 1.0
In-Reply-To: <20190220145819.30969-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: avoid broken pipe with
 certtool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 2/20/19 8:58 AM, Daniel P. Berrang=C3=A9 wrote:
> When we run "certtool | head -1" the latter command is likely to
> complete and exit before certtool has written everything it wants to
> stderr. In at least the RHEL-7 gnutls 3.3.29 this causes certtool to

A bit of a mismatch: had we actually used only 'certtool | head -1', it
would be early death before writing all it wants to stdout (not stderr).
 But since the patch itself is replacing 'certtool 2>&1 | head -1',
where stderr is also in the picture due to the additional fd
redirection, I'm not sure if it is better to just s/"certtool
|/"certtool 2>&1 |/ to match the patch, or to s/stderr/stdout/ for
brevity, or to just leave things as written.  Your call.

> quit with broken pipe before it has finished writing the desired
> output file to disk. This causes non-deterministic failures of the
> iotest 233 because the certs are sometimes zero length files.
> If certtool fails the "head -1" means we also loose any useful error

s/loose/lose/

> message it would have printed.
>=20
> Thus this patch gets rid of the pipe and post-processes the output in a
> more flexible & reliable manner.
>=20
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qemu-iotests/common.tls | 48 +++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

As the fix is for an iotest using NBD, I can take this through my tree
if no one else picks it up through some other block or iotests tree first=
.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
