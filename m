Received: from eggs.gnu.org ([209.51.188.92]:37564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1h2R56-0001GM-K3
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 20:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1h2R55-0003RH-PG
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 20:47:20 -0500
Date: Sat, 9 Mar 2019 09:46:48 +0800
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Message-ID: <20190309014648.GA28010@byw>
Reply-To: baiyaowei@cmss.chinamobile.com
References: <1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com>
	<20190306215633.GM6818@localhost.localdomain>
	<20190307084405.GB26350@byw>
	<20190307112505.GB5786@linux.fritz.box> <20190308072230.GA9529@byw>
	<20190308100826.GB5339@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308100826.GB5339@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tcmu: Introduce qemu-tcmu
 utility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Amar Tumballi <atumball@redhat.com>, Mike Christie <mchristi@redhat.com>, Prasanna Kalever <pkalever@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiubo Li <xiubli@redhat.com>, Fam Zheng <fam@euphon.net>, stefanha <stefanha@redhat.com>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>

> 
> I'm not sure what check you mean. Case 2 would need to find an existing
> export with the given name, of course, and would return an error if no
> such export exists yet.
> 
> But for care 1, isn't the image explicitly opened when the target is
> configured? And if it can't be opened, -1 is returned to libtcmu?

Yes it is. I misunderstood your meaning, forget about this.

> 
> > Actually we thought about qemu-tcmu working like case2, but felt is's quite less
> > flexible. With case2, e.g. when we want to export another new image file with
> > one qemu-tcmu already running, we have to run another qemu-tcmu with
> > the configuration of the new image file in commandline, or through QMP of the
> > running qemu-tcmu, and then configure it with targetcli. So anyway,
> > there's one more step for case2 to export a new image file. While for case1 
> > you just need to run qemu-tcmu once and all other operations will be done
> > within targetcli, which is more friendly to users i think.
> 
> Some users may call it more convenient (even though it's really the
> same, just moved to a different command, in the simple case that case 2
> supports). But it's actually not very flexible.
> 
> If we implement case 1, you can define your configuration exactly as
> with QEMU, including multiple -blockdev and -object options, and select
> the exact block node that you want to export.
> 
> In case 2, you only have a single string, which comes with many
> downsides:
> 
> * You cannot get the semantics of block nodes defined individually with
>   separate -blockdev options, but only a single tree that is managed as
>   a single unit.
> 
> * Additional objects such as iothreads or secrets cannot be included in
>   the config string, so you must split the configuration and pass some
>   parts directly to qemu-tcmu and other parts to targetcli. This is
>   inconsistent.
> 
> * You need a way to represent a possible options of a node in a string.
>   QEMU -drive already caused trouble by giving commas a special meaning.
>   This patch adds @ as a special character, without an option to escape
>   it. If you have a filename that contains @, there is no way to use it.
> 
> * For the not yet implemented QMP part: You can export only images that
>   are newly opened. You cannot export images that are already opened and
>   in use. But exporting images that are in use by the VM is the main use
>   of even having a QMP interface.
> 
> If I think a bit longer, I'm sure I can come up with more points. Case 2
> just doesn't feel right, it is like drives were configured in QEMU 0.10,
> not in 4.0, and we moved away from it for many reasons, most of which
> probably apply here, too.

Thanks for explaining the background. It comes to my mind that actually we
talked about these two cases with Fam a bit long time ago and decided to
support both these two cases. The reason why we implement case2 first is
currently we care more about exporting new opened images and it's a bit
more convenient, exporting from a VM or QMP can be added in the later
release. Do you think it's reasonable/acceptable that we support both
cases and use case2 for normal new opened images and case1 for the
circumstances you mention above?

> 
