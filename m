Received: from eggs.gnu.org ([2001:4830:134:3::10]:57380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d3k0u-0004CC-0b
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d3k0q-0003eF-Pb
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:03:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d3k0q-0003dv-H3
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:03:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3RDwtoC011103
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 10:03:14 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2xcn0yyt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 10:03:13 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 27 Apr 2017 15:03:10 +0100
Date: Thu, 27 Apr 2017 16:03:03 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <CAPnP68gpK8zzOo+g9cc6YZsQoHabH3hY4aKMXcB7b=RAitZQAw@mail.gmail.com>
References: <1493211188-24086-1-git-send-email-tgnyang@gmail.com>
	<f2769605-4cd0-7f95-0409-850258ccbaeb@redhat.com>
	<20170426170553.1d45e1d7.cornelia.huck@de.ibm.com>
	<CAPnP68gpK8zzOo+g9cc6YZsQoHabH3hY4aKMXcB7b=RAitZQAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170427160303.04250bf6.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] hw/char: remove console_exit function
 in sclp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <tgnyang@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 27 Apr 2017 20:23:51 +0800
Zihan Yang <tgnyang@gmail.com> wrote:

> OK, sorry for the confusion, I will give a new patch series. I'm not very
> familiar with
> the conventions so I wonder if someone could help clarify some principles
> for me.
> I'd like to replace all the init/exit callback of DeviceClass to
> realize/unrealize,  and
> convert return type of exit callback of some higher-level classes, like
> HDACodecDeviceClass, to void.
> 
> My first question Is it a good idea to split these patches into two series?
> For example,
> one series to convert exit callback of these higher-level classes to void,
> and then the
> other to replace all the init/exit callback of DeviceClass to
> realize/unrealize.

This is probably a good idea: converting exit callbacks to void is
relatively straightforward, while converting to realize/unrealize might
be better done while revisiting some of the modelling of the relevant
subsystems. (For example, all classes for virtio-ccw use the same exit
callback - it might be a good idea to do the same work in a common
unrealize function when you touch it anyway.)

> 
> The second question is that should I always give separate patch for
> different directories?
> One  example is that in both hw/ide and hw/block, I need to replace the
> init callback with
> realize in some high-level classes, should I give two patches or just give
> one patch for
> the work?

A better way to split is along maintainership responsibilites (which
may or may not align with directories). Again, sticking with the code I
maintain, I would merge changes to hw/char/sclp* and hw/s390x/, but not
to other code in hw/char/. Try to stick to logical units (continuing
with that example, different patches for sclp and virtio-ccw would make
sense).

The most important thing to remember when splitting changes is that you
need to preserve bisectability, i.e. every step in your patch series
needs to compile.
