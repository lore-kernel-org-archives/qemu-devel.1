Received: from eggs.gnu.org ([2001:4830:134:3::10]:35092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2hCN-0005eW-0s
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2hCM-0000wW-2y
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:50:51 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2hCL-0000w6-Sj
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:50:50 -0400
Received: by mail-wm0-x22c.google.com with SMTP id m123so73516904wma.0
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 09:50:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170424153244.2600-1-dgilbert@redhat.com>
References: <20170424153244.2600-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 17:50:28 +0100
Message-ID: <CAFEAcA8Gq5iS1uSO1czmGsGdXiSU96rTfwNkQXDrCTeFQ0f=bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/4] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 24 April 2017 at 16:32, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 4c55b1d0bad8a703f0499fe62e3761a0cd288da3:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2017-04-24' into staging (2017-04-24 14:49:48 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-hmp-20170424
>
> for you to fetch changes up to e4e3992e626c4cc7514b271807c90f587771c646:
>
>   tests: Add a tester for HMP commands (2017-04-24 15:55:35 +0100)
>
> ----------------------------------------------------------------
> HMP pull
>
> ----------------------------------------------------------------


clang doesn't like some code in test-hmp.c:

/home/petmay01/linaro/qemu-for-merges/tests/test-hmp.c:138:9: error:
logical not is only applied to the left hand side of this comparison
[-Werror,-Wlogical-not-parentheses]
    if (!strcmp("isapc", mname) == 0 ||  !strcmp("puv3", mname)
        ^                       ~~
/home/petmay01/linaro/qemu-for-merges/tests/test-hmp.c:138:9: note:
add parentheses after the '!' to evaluate the comparison first
    if (!strcmp("isapc", mname) == 0 ||  !strcmp("puv3", mname)
        ^
         (                          )
/home/petmay01/linaro/qemu-for-merges/tests/test-hmp.c:138:9: note:
add parentheses around left hand side expression to silence this
warning
    if (!strcmp("isapc", mname) == 0 ||  !strcmp("puv3", mname)
        ^
        (                      )
/home/petmay01/linaro/qemu-for-merges/tests/test-hmp.c:140:12: error:
logical not is only applied to the left hand side of this comparison
[-Werror,-Wlogical-not-parentheses]
        || !strcmp("xenfv", mname) == 0 || !strcmp("xenpv", mname)) {
           ^                       ~~
/home/petmay01/linaro/qemu-for-merges/tests/test-hmp.c:140:12: note:
add parentheses after the '!' to evaluate the comparison first
        || !strcmp("xenfv", mname) == 0 || !strcmp("xenpv", mname)) {
           ^
            (                          )
/home/petmay01/linaro/qemu-for-merges/tests/test-hmp.c:140:12: note:
add parentheses around left hand side expression to silence this
warning
        || !strcmp("xenfv", mname) == 0 || !strcmp("xenpv", mname)) {
           ^
           (                      )


It does look rather odd:

+    /* Ignore blacklisted machines that have known problems */
+    if (!strcmp("isapc", mname) == 0 ||  !strcmp("puv3", mname)
+        || !strcmp("tricore_testboard", mname)
+        || !strcmp("xenfv", mname) == 0 || !strcmp("xenpv", mname)) {
+        return;
+    }

since it's not using the same kind of expression to test
each board name -- is that deliberate, or accidental ?

I think this expression means we'll actually skip every machine...

thanks
-- PMM
