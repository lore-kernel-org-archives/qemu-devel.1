Received: from eggs.gnu.org ([2001:4830:134:3::10]:47722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXiOO-0004ti-PP
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXiOJ-0001EW-Qz
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:28:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38074 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fXiOJ-0001EO-Lz
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:27:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180514141218.28438-1-pbonzini@redhat.com>
Date: Tue, 26 Jun 2018 09:27:53 +0200
In-Reply-To: <20180514141218.28438-1-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Mon, 14 May 2018 16:12:18 +0200")
Message-ID: <87a7riovly.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] coverity-model: replay data is considered
 trusted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Replay data is not considered a possible attack vector; add a model that
> does not use getc so that "tainted data" warnings are suppressed.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/coverity-model.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/scripts/coverity-model.c b/scripts/coverity-model.c
> index c702804f41..576f48de33 100644
> --- a/scripts/coverity-model.c
> +++ b/scripts/coverity-model.c
> @@ -103,6 +103,19 @@ static int get_keysym(const name2keysym_t *table,
>      }
>  }
>  
> +
> +/* Replay data is considered trusted.  */
> +uint8_t replay_get_byte(void)
> +{
> +     uint8_t byte = 0;
> +     if (replay_file) {
> +         uint8_t c;
> +         byte = c;
> +     }
> +     return byte;
> +}
> +
> +
>  /*
>   * GLib memory allocation functions.
>   *

Coverity 2018.06 chokes on this:

    $ cov-make-library -of scripts/coverity-model.xmldb scripts/coverity-model.c 
    output file: scripts/coverity-model.xmldb
    Compiling scripts/coverity-model.c with command /opt/cov-sa-2018.06/bin/cov-emit --dir /tmp/cov-armbru/930a6fb31e5f464fc1a53354b2deb66b/cov-make-library-emit -w --no_error_recovery --emit_header_functions --no_implicit_decl --preinclude /opt/cov-sa-2018.06/library/decls.h --c scripts/coverity-model.c
    "scripts/coverity-model.c", line 110: error #20: identifier "replay_file" is
              undefined
           if (replay_file) {
               ^

    Emit for file '/work/armbru/qemu/scripts/coverity-model.c' complete.
    [ERROR] 1 error detected in the compilation of "scripts/coverity-model.c".
    ERROR: cov-emit returned with code 1

Minimal fix:

    diff --git a/scripts/coverity-model.c b/scripts/coverity-model.c
    index 48b112393b..f987ce53b8 100644
    --- a/scripts/coverity-model.c
    +++ b/scripts/coverity-model.c
    @@ -106,6 +106,7 @@ static int get_keysym(const name2keysym_t *table,
     /* Replay data is considered trusted.  */
     uint8_t replay_get_byte(void)
     {
    +    void *replay_file;
          uint8_t byte = 0;
          if (replay_file) {
              uint8_t c;

Alternatively, dumb down to:

    /* Replay data is considered trusted.  */
    uint8_t replay_get_byte(void)
    {
        uint8_t byte;
        return byte;
    }

Got a preference?
