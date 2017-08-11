Received: from eggs.gnu.org ([2001:4830:134:3::10]:39572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dg9Yz-0007Gx-1W
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dg9Yt-0002Q5-4q
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:01:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dg9Ys-0002Ot-UU
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:01:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D8D4975BD
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 13:01:09 +0000 (UTC)
Date: Fri, 11 Aug 2017 15:01:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170811150105.466d5209.cohuck@redhat.com>
In-Reply-To: <9cd0cd32-5c2d-4c07-38fd-ca63ba204abf@redhat.com>
References: <20170811114723.12044-1-cohuck@redhat.com>
	<9cd0cd32-5c2d-4c07-38fd-ca63ba204abf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, 11 Aug 2017 13:56:37 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 11.08.2017 13:47, Cornelia Huck wrote:

> > diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> > index 11f48b049c..38664a0594 100644
> > --- a/tests/boot-serial-test.c
> > +++ b/tests/boot-serial-test.c
> > @@ -78,7 +78,8 @@ static void test_machine(const void *data)
> >      fd = mkstemp(tmpname);
> >      g_assert(fd != -1);
> >  
> > -    args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
> > +    args = g_strdup_printf("-M %s,accel=tcg:kvm "
> > +                           "-chardev file,id=serial0,path=%s"
> >                             " -no-shutdown -serial chardev:serial0 %s",
> >                             test->machine, tmpname, test->extra);  
> 
> I think I'd prefer "kvm:tcg" here to speed up the test if possible.

Sure, can turn that around.

> 
> The reason for only using "tcg" in the past was that there was an
> annoying warning message "kvm accelerator not found" or so when also
> specifying kvm here, but that has been fixed just recently, so "kvm:tcg"
> should be fine now here, too.

Yup, it's best to try both (especially as we can't rely on tcg being
available anymore).
