Received: from eggs.gnu.org ([2001:4830:134:3::10]:36419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fIYdI-0007ip-Se
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fIYdE-0008PD-Uz
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:00:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38056 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fIYdE-0008OS-Qd
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:00:40 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180514141218.28438-1-pbonzini@redhat.com>
Date: Tue, 15 May 2018 14:00:38 +0200
In-Reply-To: <20180514141218.28438-1-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Mon, 14 May 2018 16:12:18 +0200")
Message-ID: <87r2md6sd5.fsf@dusky.pond.sub.org>
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
   /* Tainting */

   typedef struct {} name2keysym_t;
   static int get_keysym(const name2keysym_t *table,
                         const char *name)
   {
       int result;
       if (result > 0) {
           __coverity_tainted_string_sanitize_content__(name);
           return result;
       } else {
           return 0;
>      }
>  }
>  
> +

Does the new model go under /* Tainting */ ?

If yes, I'd like to have just one blank line here.

> +/* Replay data is considered trusted.  */

If no, I'd like to insert one here.

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
