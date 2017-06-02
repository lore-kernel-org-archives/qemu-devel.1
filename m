Received: from eggs.gnu.org ([2001:4830:134:3::10]:38827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vdrok@mirantis.com>) id 1dGkmz-0006gl-OL
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vdrok@mirantis.com>) id 1dGkmy-0002yG-6c
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:30:45 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:34782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vdrok@mirantis.com>) id 1dGkmy-0002y1-06
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:30:44 -0400
Received: by mail-qt0-x22d.google.com with SMTP id c13so56773272qtc.1
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 04:30:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEcfeEyK58zmcggGVmU4k7htQeo-0+s609Wngm=7k9nKCP=WVg@mail.gmail.com>
References: <CAEcfeEx1nB-jZwLO1kmt1Mv+3JoBtrWPVpCaAkSEpLXne6oL1Q@mail.gmail.com>
	<CABYiri8vcRmOiH6ogGjXULuZXMo1Dh2a2nagLhSfUnS_B9+1Vg@mail.gmail.com>
	<CAEcfeEysi6TDp1RwRmvVh4RHO=VcXZ0-1JyMYC3uoTFjgoSDbg@mail.gmail.com>
	<CAEcfeEyK58zmcggGVmU4k7htQeo-0+s609Wngm=7k9nKCP=WVg@mail.gmail.com>
From: Vladyslav Drok <vdrok@mirantis.com>
Date: Fri, 2 Jun 2017 14:30:41 +0300
Message-ID: <CAEcfeEwLuK2=U9gOzOiCwLJGUxqShK7Ev-qCDFR7V5MhVPYxCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Tracking hugepages usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, andrey@xdel.ru

On Thu, Jun 1, 2017 at 7:24 PM, Vladyslav Drok <vdrok@mirantis.com> wrote:

>
>
> On Thu, Jun 1, 2017 at 2:55 PM, Vladyslav Drok <vdrok@mirantis.com> wrote:
>
>>
>>
>> On Thu, Jun 1, 2017 at 1:56 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
>>
>>> On Thu, Jun 1, 2017 at 1:38 PM, Vladyslav Drok <vdrok@mirantis.com>
>>> wrote:
>>> > Hello qemu community!
>>> >
>>> > I come from openstack world, and one of our customers complains about
>>> an
>>> > issue with huge pages on compute nodes. From the "virsh frepages
>>> --all" and
>>> > "cat /proc/meminfo", they see that 4 huge pages are consumed:
>>> >
>>> > http://paste.openstack.org/show/611186/
>>> >
>>> > In total there are 239 1G pages, 120 in numa node 0, and 119 in numa
>>> node
>>> > 1. There are no VMs running at this point.
>>> >
>>> > When trying to find out what consumes the 4 1G huge pages from node 0,
>>> I
>>> > was suggesting "grep 1048576 /proc/*/numa_maps" to find out which
>>> processes
>>> > are using 1G pages, but in this particular case it shows no processes.
>>> > While when some VM is running, I can see the qemu process that's
>>> consuming
>>> > huge pages, numa_maps reports the correct amount of pages,
>>> corresponding to
>>> > what has been requested for the VM's RAM.
>>> >
>>> > Are there any recommended ways for trying to track what consumes these
>>> 4
>>> > "lost" pages? (I might be a bit slow providing more info, as I don't
>>> have
>>> > access to this environment :( )
>>> >
>>> > Thanks,
>>> > Vlad
>>>
>>> Could you please try to walk against /proc/[0-9]/smaps to check that
>>> these pages are not claimed by any process?
>>>
>>
>> Thanks for the suggestion! Will provide the results as soon as I have it.
>>
>> So, here (in the attachment, is is a bit lengthy so, sorry, was not able
> to use paste :)) is an output of ps -F and smaps for processes that have
> any entry with KernelPageSize: 1048576 kB. In this case, there are two
> instances running on this compute node, 16 GB and 32 GB. The usage reported
> by qemu processes seems to report huge page count correctly. In case of
> ovs-vswitchd process, I'm not sure how to interpret the output, as if I
> just add up the number of pages used by that, it is much bigger than it's
> reported as used, any hint on that would be much appreciated :) Though the
> ovs-vswitchd process is run with --huge-dir /mnt/huge_ovs_2M which is where
> 2 mb pages are mounted, so I supposed it should not use the 1G pages.
>

Reuploaded it on google drive just in case, here -
https://drive.google.com/a/mirantis.com/file/d/0BwCsFeCyKJjMYjdTNFJ0Tnd6OFU/view?usp=sharing


>
> I'll also try to request the output for a compute that does not have any
> instances running but still having some pages used, so the problem is a bit
> more clear.
>

So here is the paste for the compute node that does not have any instances
(smaller and easier to notice a problem) -
http://paste.openstack.org/show/cvT96Bp0Lu1zpwqS0jDa/, smaps does not
report any processes using 1G pages, while there are 4 used by something as
reported by meminfo.


>
> Thanks,
> Vlad
>
