Received: from eggs.gnu.org ([2001:4830:134:3::10]:58102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egCs5-0002Ye-2n
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egCrw-0006Xm-OT
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:05:28 -0500
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:51519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1egCrw-0006Ww-HE
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:05:20 -0500
Received: from player730.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 5E7CFD36B3
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 18:05:18 +0100 (CET)
Date: Mon, 29 Jan 2018 18:05:06 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180129180506.33520c68@bahia.lan>
In-Reply-To: <f0bd7f3d-d3ba-556b-3c69-cbfaf7d7b929@huawei.com>
References: <081955e1-84ec-4877-72d4-f4e8b46be350@huawei.com>
	<20180112171416.6048ae9e@bahia.lan>
	<e059ddfb-030d-98b6-8e6e-4938270bcebf@huawei.com>
	<20180119112733.4a9dd43f@bahia.lan>
	<05660a29-b22d-7bd6-91e2-37c54b5f2194@huawei.com>
	<899644b1-e401-8ed5-8a49-1f0e2dbf9b2b@huawei.com>
	<20180119190555.35127373@bahia.lan>
	<e6ad35e8-2fda-8318-c043-dcf092cc0daa@huawei.com>
	<f0bd7f3d-d3ba-556b-3c69-cbfaf7d7b929@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] qid path collision issues in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Veaceslav Falico <veaceslav.falico@huawei.com>
Cc: Eduard Shishkin <eduard.shishkin@huawei.com>, Antonios Motakis <antonios.motakis@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "vfalico@gmail.com" <vfalico@gmail.com>, "Wangguoli (Andy)" <andy.wangguoli@huawei.com>, Jiangyiwen <jiangyiwen@huawei.com>, "zhangwei
	(CR)" <zhangwei555@huawei.com>, "Emilio G. Cota" <cota@braap.org>

On Thu, 25 Jan 2018 17:08:40 +0100
Veaceslav Falico <veaceslav.falico@huawei.com> wrote:

> On 1/25/2018 3:46 PM, Veaceslav Falico wrote:
[...]
> > 
> > I've reproduced it today without fscache:
> > 
> > host:
> > mount -o bind /tmp/mounted t1
> > mount -o bind /tmp/mounted t2
> > 
> > guest:
> > / # tail -f t1/file &
> > / # 321
> > 
> > / # cat t2/file
> > 321
> > / #
> > 
> > host:
> > mv t1/file t1/file_moved
> > 
> > guest:
> > / # cat t2/file
> > cat: can't open 't2/file': No such file or directory
> > / # mount | grep fscache
> > / #  
> 
> Sorry, disregard this test case, it's operating normally -
> when we move the t1/file, we also move the t2/file, as they're
> the same directory... Sorry, it's a brainfart after a long
> discussion about the issue :).
> 

No problem :)

> So, it's still not reproducible without (fs)cache guest-side.
> 
> 
> Anyway, the question below still stands - is the guest
> allowed to re-use the FIDs for the files with same QIDs?
> 

AFAIU FIDs have a 1:1 relation to either a path in the file hierarchy or
to an open file. I don't think they can be re-used.

> > 
> > Also, per internal discussions, we're not sure if the guest side
> > is allowed to reuse the FIDs opened previously for same QID.paths.
> > 
> > QEMU holds FID.path for each FID, which contains the actual FS path,
> > i.e. "/path/to/file". 
> > 
> > So, if we (guest) have two "identical" (per QID.path and RFC) files
> > (f1 and f2), though in different directories (host and guest), and 
> > we've accessed f1 once (FID 10, for example) - are we allowed to
> > re-use FID 10 for f2, if f1's QID.path == f2's QID.path ?
> >   
> >>  
> >>>  
> >>>>
> >>>> Thanks,
> >>>> Eduard.
> >>>>     
> >>>>>    
> >>>>>>>    
> >>>>>>>> With our proof of concept patch, the issues caused by qid path collisions go away, so it can be seen as an interim solution of sorts. However, the chance of collisions is not eliminated, we are just replacing the current strategy, which is almost guaranteed to cause collisions in certain use cases, with one that makes them more rare. We think that a virtio feature flag for longer qid paths is the only way to eliminate these issues completely.
> >>>>>>>>
> >>>>>>>> This is the extent that we were able to analyze the issue from our side, we would like to hear if there are some better ideas, or which approach would be more appropriate for upstream.
> >>>>>>>>
> >>>>>>>> Best regards,
> >>>>>>>>    
> >>>>>>>
> >>>>>>> Cheers,
> >>>>>>>
> >>>>>>> -- 
> >>>>>>> Greg
> >>>>>>>    
> >>>>>>    
> >>>>>    
> >>>>
> >>>> .
> >>>>     
> >>>
> >>>  
> >>
> >> .
> >>  
> >   
> 
> 
