Received: from eggs.gnu.org ([2001:4830:134:3::10]:42288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPPtE-0000jo-GZ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPPtB-0003Ob-9h
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:28:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48321
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cPPtB-0003OT-4c
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:28:41 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v068ScGt108180
	for <qemu-devel@nongnu.org>; Fri, 6 Jan 2017 03:28:40 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27t2ebt70w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 03:28:40 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 6 Jan 2017 13:58:35 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170106075407.GO13763@umbus.fritz.box>
References: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1483683296-32568-3-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170106075407.GO13763@umbus.fritz.box>
Date: Fri, 06 Jan 2017 13:58:19 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87pok01tjw.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v1 02/14] target-ppc: Add xxinsertw
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

David Gibson <david@gibson.dropbear.id.au> writes:

> [ Unknown signature status ]
> On Fri, Jan 06, 2017 at 11:44:44AM +0530, Nikunj A Dadhania wrote:
>> xxinsertw: VSX Vector Insert Word
>> 
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>
> The comments I had about out of bounds shifts don't seem to have been
> addressed here.

Bounds are addressed inside the for condition:

#if defined(HOST_WORDS_BIGENDIAN)
    ins_index = index;
    for (i = 0; i < es && ins_index < 16; i++, ins_index++) {
                          ^^^^^^^^^^^^^^
        xt.u8[ins_index] = xb.u8[8 - es + i];
    }
#else
    ins_index = 15 - index;
    for (i = es - 1; i >= 0 && ins_index >= 0; i--, ins_index--) {
                               ^^^^^^^^^^^^^^
        xt.u8[ins_index] = xb.u8[8 + i];
    }
#endif

That way ins_index will be within 0 - 15. Let me know if I have missed
something.

Regards
Nikunj
