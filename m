Received: from eggs.gnu.org ([2001:4830:134:3::10]:50229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dg8YW-0002pu-Th
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dg8YT-0006tI-Pc
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:56:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dg8YT-0006t0-Jp
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:56:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 573DD2CE97D
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 11:56:40 +0000 (UTC)
References: <20170811114723.12044-1-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9cd0cd32-5c2d-4c07-38fd-ca63ba204abf@redhat.com>
Date: Fri, 11 Aug 2017 13:56:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170811114723.12044-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] boot-serial-test: fallback to kvm
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 11.08.2017 13:47, Cornelia Huck wrote:
> Currently, at least x86_64 and s390x support building with --disable-tcg.
> Instead of forcing tcg (which causes the test to fail on such builds),
> allow to use kvm as well.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> Not sure who should merge this. I can add it to the s390 tree if nobody
> else takes it.

Maybe CC: Paolo for "Character devices"? But sure, if nobody else takes
it, it should be fine in the s390 tree, too.

> ---
>  tests/boot-serial-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 11f48b049c..38664a0594 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -78,7 +78,8 @@ static void test_machine(const void *data)
>      fd = mkstemp(tmpname);
>      g_assert(fd != -1);
>  
> -    args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
> +    args = g_strdup_printf("-M %s,accel=tcg:kvm "
> +                           "-chardev file,id=serial0,path=%s"
>                             " -no-shutdown -serial chardev:serial0 %s",
>                             test->machine, tmpname, test->extra);

I think I'd prefer "kvm:tcg" here to speed up the test if possible.

The reason for only using "tcg" in the past was that there was an
annoying warning message "kvm accelerator not found" or so when also
specifying kvm here, but that has been fixed just recently, so "kvm:tcg"
should be fine now here, too.

 Thomas
