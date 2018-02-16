Received: from eggs.gnu.org ([2001:4830:134:3::10]:38131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emd3g-0001eE-0U
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emd3f-00063j-3a
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:15:59 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:33147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emd3e-00063T-UN
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:15:59 -0500
Received: by mail-oi0-x234.google.com with SMTP id l124so1940646oib.0
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 02:15:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518761564-9899-1-git-send-email-thuth@redhat.com>
References: <1518761564-9899-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2018 10:15:37 +0000
Message-ID: <CAFEAcA_s1C3md4Vw6fQu2GLy=hZBLDSrvnHppQswL8+K1giLwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests/boot-serial-test: Fix problem with
 timeout due to dropped characters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 16 February 2018 at 06:12, Thomas Huth <thuth@redhat.com> wrote:
> Commit 92b540dac9fc3a5 introduce a counter to handle the timeouts in a
> better way. But in case ccnt reaches 512, the current read character is
> ignored - and if that character is part of the string that we are looking
> for, the test fails to match the string.
>
> Almost all of the tests look for a string within the first 512 bytes of
> firmware output, so the problem never triggered there. But the hppa test
> that has been added recently looks for a longer string at the very end of
> a long output, thus there's a chance that we miss a character there so
> that the test fails unexpectedly. Fix it by *not* reading and dropping a
> character if the counter reaches 512.
>
> Fixes: 92b540dac9fc3a572c7342edd0b073000f5a6abf
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  @Peter: Since this fixes the problem with running "make check", could
>  you maybe apply this directly to the master branch? Thanks, and sorry
>  for the inconvenience!
>
>  tests/boot-serial-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index ea87a80..696f7a3 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -101,7 +101,7 @@ static void check_guest_output(const testdef_t *test, int fd)
>      /* Poll serial output... Wait at most 60 seconds */
>      for (i = 0; i < 6000; ++i) {
>          ccnt = 0;
> -        while ((nbr = read(fd, &ch, 1)) == 1 && ccnt++ < 512) {
> +        while (ccnt++ < 512 && (nbr = read(fd, &ch, 1)) == 1) {
>              if (ch == test->expect[pos]) {
>                  pos += 1;
>                  if (test->expect[pos] == '\0') {

I did a test build with this, but OpenBSD's compiler
now complains:

/home/qemu/tests/boot-serial-test.c: In function 'test_machine':
/usr/local/include/glib-2.0/glib/gmacros.h:370:7: warning: 'nbr' may
be used uninitialized in this function [-Wmaybe-uninitialized]
    if (expr)                                    \
       ^
/home/qemu/tests/boot-serial-test.c:114:12: note: 'nbr' was declared here
     int i, nbr, pos = 0, ccnt;
            ^

This is obviously a false positive, but we can silence it by
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -111,7 +111,7 @@ static testdef_t tests[] = {
 static void check_guest_output(const testdef_t *test, int fd)
 {
     bool output_ok = false;
-    int i, nbr, pos = 0, ccnt;
+    int i, nbr = 0, pos = 0, ccnt;
     char ch;

     /* Poll serial output... Wait at most 60 seconds */

so I'll just squash that change in if that's ok?

thanks
-- PMM
