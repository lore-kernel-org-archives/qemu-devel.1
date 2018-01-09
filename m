Received: from eggs.gnu.org ([2001:4830:134:3::10]:57265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eYrqG-0005VO-0Y
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:13:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eYrq8-00047y-CJ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:13:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.vnet.ibm.com>)
	id 1eYrq8-000461-3T
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:13:08 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w09BAbSL132086
	for <qemu-devel@nongnu.org>; Tue, 9 Jan 2018 06:13:06 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fcqq4d5c6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 06:13:06 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.vnet.ibm.com>;
	Tue, 9 Jan 2018 06:13:04 -0500
References: <20180109092103.18458-1-sjitindarsingh@gmail.com>
	<20180109092103.18458-2-sjitindarsingh@gmail.com>
From: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <muriloo@linux.vnet.ibm.com>
Date: Tue, 9 Jan 2018 09:13:00 -0200
MIME-Version: 1.0
In-Reply-To: <20180109092103.18458-2-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <b8e59719-0b88-3cab-9d65-491cb35d5e03@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [RFC 1/3] hw/ppc/spapr_caps:
 Rework spapr_caps to use uint8 internal representation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org
Cc: paulus@ozlabs.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 01/09/2018 07:21 AM, Suraj Jitindar Singh wrote:
> Currently spapr_caps are tied to boolean values (on or off). This patch
> reworks the caps so that they can have any value between 0 and 127,
> inclusive. This allows more capabilities with various values to be
> represented in the same way internally. Capabilities are numbered in
> ascending order. The internal representation of capability values is an
> array of uint8s in the sPAPRMachineState, indexed by capability number.
> Note: The MSB (0x80) of a capability is reserved to track whether the
>       capability was set from the command line.
> 
> Capabilities can have their own name, description, options, getter and
> setter functions, type and allow functions. They also each have their own
> section in the migration stream. Capabilities are only migrated if they
> were explictly set on the command line, with the assumption that
> otherwise the default will match.
> 
> On migration we ensure that the capability value on the destination
> is greater than or equal to the capability value from the source. So
> long at this remains the case then the migration is considered
> compatible and allowed to continue.
> 
> This patch implements generic getter and setter functions for boolean
> capabilities. It also converts the existings cap-htm, cap-vsx and
> cap-dfp capabilities to this new format.

Hi, Suraj.

I've got the impression that this patch does a lot of things. What about
splitting this patch into the following?

- rename spapr_has_cap() -> spapr_get_cap()
- introduce each spapr_cap_[gs]et_bool() in separate patches
- make use of spapr_cap[gs]et_bool()
- convert capabilities internal representation to uint8
- add each new capability separately

Perhaps it can be broken into even smaller changes.

Cheers
Murilo
