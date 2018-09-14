Received: from eggs.gnu.org ([2001:4830:134:3::10]:54423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0pSs-0003Is-S7
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0pSq-0003Ru-52
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:52:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g0pSp-0003RU-S0
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:52:55 -0400
References: <CAB3eZfvRJRR1k0X1MQivPMcLRNZR07yv1ZxBiDAkF3qOryK0UQ@mail.gmail.com>
	<20180912074402.GB11164@lemon.usersys.redhat.com>
	<CAB3eZfsGcWP2WdZXocQ6wdztBbRofgXOVi+N=W3FEPxH0N1hyA@mail.gmail.com>
	<20180914060543.GB3653@lemon.usersys.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f1681ab9-53a9-989c-b793-1f98ec38c5c7@redhat.com>
Date: Fri, 14 Sep 2018 09:52:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180914060543.GB3653@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Can I convert backing file to internal snapshot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, lampahome <pahome.chen@mirlab.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9/14/18 1:05 AM, Fam Zheng wrote:
> On Fri, 09/14 12:23, lampahome wrote:
>> Can I convert from internap snapshot to external snapshot?
>> If there's 3 snapshots in one qcow2, can I convert them all to external
>> snapshots?
> 
> Qcow2 doesn't track internal snapshot dependencies like external snapshot, so
> there is no direct way to create the "differentiative" or "delta" images in the
> same way as would be with external snapshots. In theory it's possible to convert
> all internal snapshots to separate full images then create delta by
> sector-by-sector comparison.

In fact, qemu-img documents that you can do:

            You can use "rebase" to perform a "diff" operation on two disk
            images.  This can be useful when you have copied or cloned a 
guest,
            and you want to get back to a thin image on top of a template or
            base image.

            Say that "base.img" has been cloned as "modified.img" by copying
            it, and that the "modified.img" guest has run so there are 
now some
            changes compared to "base.img".  To construct a thin image 
called
            "diff.qcow2" that contains just the differences, do:

                    qemu-img create -f qcow2 -b modified.img diff.qcow2
                    qemu-img rebase -b base.img diff.qcow2

            At this point, "modified.img" can be discarded, since 
"base.img +
            diff.qcow2" contains the same information.


So yes, the process is to first use multiple 'qemu-img convert -l' to 
extract the separate points in time into separate files, and then 
'qemu-img rebase' as above to convert those separate points in time back 
into differential files.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
