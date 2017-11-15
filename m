Received: from eggs.gnu.org ([2001:4830:134:3::10]:42902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eEuGf-000240-7f
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eEuGc-0005Eq-41
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:46:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eEuGb-0005BT-RL
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:45:58 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <6e0e65ef.427f.15faf8d41e9.Coremail.lichunguang@hust.edu.cn>
	(Chunguang Li's message of "Sun, 12 Nov 2017 17:26:31 +0800
	(GMT+08:00)")
References: <6e0e65ef.427f.15faf8d41e9.Coremail.lichunguang@hust.edu.cn>
Reply-To: quintela@redhat.com
Date: Wed, 15 Nov 2017 10:45:44 +0100
Message-ID: <874lpvdgdz.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Abnormal observation during migration: too many
 "write-not-dirty" pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chunguang Li <lichunguang@hust.edu.cn>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, stefanha@redhat.com

"Chunguang Li" <lichunguang@hust.edu.cn> wrote:
> Hi all! 

Hi

Sorry for the delay, I was on vacation an still getting up to speed.

> I got a very abnormal observation for the VM migration. I found that many pages marked as dirty during
> migration are "not really dirty", which is, their content are the same as the old version. 

I think your test is quite good, and I am also ashamed that 80% of
"false" dirty pages is really a lot.

> I did the migration experiment like this: 
>
> During the setup phase of migration, first I suspended the VM. Then I copied all the pages within the guest
> physical address space to a memory buffer as large as the guest memory size. After that, the dirty tracking
> began and I resumed the VM. Besides, at the end
> of each iteration, I also suspended the VM temporarily. During the suspension, I compared the content of all
> the pages marked as dirty in this iteration byte-by-byte with their former copies inside the buffer. If the
> content of one page was the same as its former copy, I recorded it as a "write-not-dirty" page (the page is
> written exactly with the same content as the old version). Otherwise, I replaced this page in the buffer with
> the new content, for the possible comparison in the future. After the reset of the dirty bitmap, I resumed the
> VM. Thus, I obtain the proportion of the write-not-dirty pages within all the pages marked as dirty for each
> pre-copy iteration. 


vhost and friends could make a small difference here, but in general,
this approach should be ok.

> I repeated this experiment with 15 workloads, which are 11 CPU2006 benchmarks, Memcached server,
> kernel compilation, playing a video, and an idle VM. The CPU2006 benchmarks and Memcached are
> write-intensive workloads. So almost all of them did not converge to stop-copy. 

That is the impressive part, 15 workloads.  Thanks for taking the effor.

BTW, do you have your qemu changes handy, just to be able to test
locally, and "review" how do you measure things.


> Startlingly, the proportions of the write-not-dirty pages are quite high. Memcached and three CPU2006
> benchmarks(zeusmp, mcf and bzip2) have the most high proportions. Their proportions of the write-not-dirty
> pages within all the dirty pages are as high as 45%-80%.

Or the workload does really stupid things like:

a = 0;
a = 1;
a = 0;

This makes no sense at all.

Just in case, could you try to test this with xbzrle?  It should go well
with this use case (but you need to get a big enough buffer to cache
enough memory).


> The proportions of the other workloads are about
> 5%-20%, which are also abnormal. According to my intuition, the proportion of write-not-dirty pages should be
> far less than these numbers. I think it should be quite a particular case that one page is written with exactly
> the same content as the former data. 

I agree with that.

> Besides, the zero pages are not counted for all the results. Because I think codes like memset() may write
> large area of pages to zero pages, which are already zero pages before. 
>
> I excluded some possible unknown reasons with the machine hardware, because I repeated the experiments
> with two sets of different machines. Then I guessed it might be related with the huge page feature. However,
> the result was the same when I turned the huge page feature off in the OS. 

Huge page could have caused that.  Remember that we have transparent
huge pages.  I have to look at that code.

> Now there are only two possible reasons in my opinion. 
>
> First, there is some bugs in the KVM kernel dirty tracking mechanism. It may mark some pages that do not
> receive write request as dirty. 

That is a posibilty.

> Second, there is some bugs in the OS running inside the VM. It may issue some unnecessary write
> requests. 
>
> What do you think about this abnormal phenomenon? Any advice or possible reasons or even guesses? I
> appreciate any responses, because it has confused me for a long time. Thank you.

I would like to reproduce this.

Thanks for bringing this to our attention.

Later, Juan.
