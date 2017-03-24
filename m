Received: from eggs.gnu.org ([2001:4830:134:3::10]:42777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1crNi3-0005ZJ-Aw
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1crNhz-0002fF-8p
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:48:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1crNhz-0002en-2L
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:48:43 -0400
References: <CAFEAcA_sboyuxUo9b_WAc18Ov9ehfUnura7C5r5ZzfDmjd-XLw@mail.gmail.com>
	<ff8093ef-78ee-b2ab-99d4-6957cbeac07d@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ede74d2f-e6fc-4459-2c58-98c2c8c47fcf@redhat.com>
Date: Fri, 24 Mar 2017 12:48:38 +0100
MIME-Version: 1.0
In-Reply-To: <ff8093ef-78ee-b2ab-99d4-6957cbeac07d@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-system-s390x tests/boot-serial-test
 intermittent failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>



On 24/03/2017 12:11, Christian Borntraeger wrote:
> One idea. Maybe qemu exits before the other side is ready.
> Does reverting
> 
> commit 864111f422babcf8ce837fb47f7f9e1948446f22
> Author:     Christian Borntraeger <borntraeger@de.ibm.com>
> AuthorDate: Tue Oct 18 09:29:54 2016 +0200
> Commit:     Paolo Bonzini <pbonzini@redhat.com>
> CommitDate: Wed Nov 2 09:28:56 2016 +0100
> 
>     vl: exit qemu on guest panic if -no-shutdown is not set
> 
> help?

Didn't test, but this:

> If yes, does 
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 57edf6a..11f48b0 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -79,8 +79,8 @@ static void test_machine(const void *data)
>      g_assert(fd != -1);
>  
>      args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
> -                           " -serial chardev:serial0 %s", test->machine,
> -                           tmpname, test->extra);
> +                           " -no-shutdown -serial chardev:serial0 %s",
> +                           test->machine, tmpname, test->extra);
>  
>      qtest_start(args);
>      unlink(tmpname);
> 
> also help?

seems to help (survives about 1 minute, while usually it fails in a few
seconds).

Paolo
