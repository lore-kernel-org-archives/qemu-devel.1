Received: from eggs.gnu.org ([2001:4830:134:3::10]:45199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dqG7b-00067L-9m
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dqG7W-0001pT-Kv
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:02:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dqG7W-0001o5-FQ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:02:42 -0400
Date: Fri, 8 Sep 2017 12:02:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170908120238.13a13ce0.cohuck@redhat.com>
In-Reply-To: <20170908034100.GH31680@bjsdjshi@linux.vnet.ibm.com>
References: <20170905182546.00457332.cohuck@redhat.com>
	<fe102a7a-e998-8ebe-b94d-e653c4f66c39@linux.vnet.ibm.com>
	<20170906043108.GY31680@bjsdjshi@linux.vnet.ibm.com>
	<8946b1ec-4d14-c953-deab-aaded7cd2c9d@linux.vnet.ibm.com>
	<20170906162019.45eeec4a.cohuck@redhat.com>
	<cc6eab96-969d-eb66-91b5-cdb965c1bcbb@linux.vnet.ibm.com>
	<20170907085831.GF31680@bjsdjshi@linux.vnet.ibm.com>
	<20170907122400.5b2e3faa.cohuck@redhat.com>
	<27b2addf-0d1c-81d7-1e82-1a8cdac70231@linux.vnet.ibm.com>
	<20170907134134.00f387e8.cohuck@redhat.com>
	<20170908034100.GH31680@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/9] s390x: refactor error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Fri, 8 Sep 2017 11:41:00 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> I think the difficult part is in the Qemu side. For either A or B, in
> Qemu, we'd need to return a cc0 to indicate the channel program is
> accepted successfully by the device, and then update the virtual IRB and
> inject an I/O interrupt to notify the guest.
> 
> The question is, now we need to map -EFAULT to cc0? This is too odd...

It's not odd at all, if you consider these as two stages:

- Initial acceptance of the command, set cc 0 to indicate you got it.
- Execution of the start function. This can then fail, of course.

> And we need to find a proper place to do the interrupt injection. I
> guess it could be in the sch_handle_start_func_passthrough().

Probably, yes.

> 
> If we do not like such modification in the Qemu side, then A is not the
> way to go.
> 
> And for B, we need to update the IRB area of the I/O region in the three
> cases listed in the former mail, and:
> 1. We need to set the ret_code as 0 for them, so that Qemu could map it
>    to cc0.
> 2. We need to signal Qemu to fetch the IRB we generated with the checks.
> All of these are doable I think.
> 
> Any comment for the above thoughts?
> 
