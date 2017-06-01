Received: from eggs.gnu.org ([2001:4830:134:3::10]:59986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dGSEV-0004UD-Or
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dGSET-0006jx-AA
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:41:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49912
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dGSET-0006iq-3w
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:41:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51Fd4PE023166
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 11:41:51 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2atm3qdsmp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 11:41:51 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 1 Jun 2017 12:41:49 -0300
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601040646.GB27525@in.ibm.com>
	<149629114184.3207.6757927820110284250@loki>
	<20170601053037.GC13397@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 1 Jun 2017 12:41:40 -0300
MIME-Version: 1.0
In-Reply-To: <20170601053037.GC13397@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <d8d8aa98-46de-ae2e-1da9-25e9a53fd89b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/4] spapr:DRC cleanups (part I)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: lvivier@redhat.com, sursingh@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>



On 06/01/2017 02:30 AM, David Gibson wrote:
> On Wed, May 31, 2017 at 11:25:41PM -0500, Michael Roth wrote:
>> Quoting Bharata B Rao (2017-05-31 23:06:46)
>>> On Thu, Jun 01, 2017 at 11:52:14AM +1000, David Gibson wrote:
>>>> The code managing DRCs[0] has quite a few things that are more
>>>> complicated than they need to be.  In particular the object
>>>> representing a DRC has a bunch of method pointers, despite the fact
>>>> that there are currently no subclasses, and even if there were the
>>>> method implementations would be unlikely to differ.
>>> So you are getting rid of a few methods. How about other methods ?
>>> Specially attach and detach which have incorporated all the logic needed
>>> to handle logical and physical DRs into their implementations ?
>> I would avoid any methods that incorporate special-casing for
>> physical vs. logical DRCs, since that seems like a good logical
>> starting point for moving to 'physical'/'logical' DRC
>> sub-classes to help simplify the increasingly complicated
>> state-tracking.
> Right, I'm looking at making subclasses for each of the DRC types.
> Possibly with intermediate subclasses for physical vs. logical, we'll
> see how it works out.

Back in the DRC migration patch series I talked with Mike about refactoring
the DRC code in such fashion (physical DRC and logical DRC). But first I 
would
implement some kind of unit testing in this code to avoid breaking too much
stuff during this refactoring.

I am not sure about the effort to implementing unit test in the current 
DRC code.
This series is simplifying the DRC code, making it more minimalist and 
possibly
easier to be tested. In the end it would be a first step towards unit 
testing.

However, there is the issue of backward compatibility. I fear this DRC 
refactoring
of Logical/Physical DRC would be too drastic to maintain such compatibility
(assuming that it is not already broken). If this refactor goes live 
only in 2.11 then
we will have a hard time to migrate from 2.11 to 2.10.

All that said, I believe we can live without unit testing for a little 
longer and if
we're going for this Physical/DRC refactoring, we need to push it for 
2.10. We can
think about unit test later with the refactored code. Feel free to send 
to me any
unfinished/beta DRC refactoring code you might be working on and want
tested. I can help in the refactoring too, just let me know.


Daniel


>
>> I also don't think we should expose DRC internal fields to
>> outside callers (which attach/detach would involve).
> Well.. just changing attach/detach to plain functions instead of
> methods wouldn't break that.
>
>> This
>> series does that to some extent with the RTAS calls, but
>> since those are now moved to spapr_drc.c it makes more sense.
> Right - the semantics of the RTAS calls are tied closely to the DRC
> semantics, so I don't think there's any point considering the RTAS
> calls to be "outside" the DRC code itself.
>
