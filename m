Received: from eggs.gnu.org ([2001:4830:134:3::10]:42357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d847n-0004Y7-60
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d847k-00042G-0p
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:20:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d847j-000420-O4
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:20:15 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v49C9CVj084842
	for <qemu-devel@nongnu.org>; Tue, 9 May 2017 08:20:14 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2abcj9ax8h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 08:20:14 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 9 May 2017 13:20:10 +0100
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-4-pasic@linux.vnet.ibm.com>
	<20170508164505.GG2120@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 9 May 2017 14:20:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170508164505.GG2120@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <71ac8187-267a-5155-1949-4d1e7576be0c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 03/10] s390x/css: add vmstate entities for
 css
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>



On 05/08/2017 06:45 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>> As a preparation for switching to a vmstate based migration let us
>> introduce vmstate entities (e.g. VMStateDescription) for the css entities
>> to be migrated. Alongside some comments explaining or indicating the not
>> migration of certain members are introduced too.
>>
>> No changes in behavior, we just added some dead code -- which should
>> rise to life soon.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/css.c         | 276 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/s390x/css.h |  10 +-
[..]
>>  typedef struct IoAdapter {
>>      uint32_t id;
>>      uint8_t type;
>> @@ -60,10 +262,34 @@ typedef struct ChannelSubSys {
>>      uint64_t chnmon_area;
>>      CssImage *css[MAX_CSSID + 1];
>>      uint8_t default_cssid;
>> +    /* don't migrate */
        /* populated at bus init time, not subject to migration */
>>      IoAdapter *io_adapters[CSS_IO_ADAPTER_TYPE_NUMS][MAX_ISC + 1];
>> +    /* don't migrate */
> 
> You don't say *why*
> 

Because its obvious if you stare at the code for a month or so.
Joke aside let me try again (above and below).

> Dave
> 
        /* migrated by the owning device when get_indicator is called */
>>      QTAILQ_HEAD(, IndAddr) indicator_addresses;

That is by vmstate_info_ind_addr.get == css_get_ind_addr

I know it is convoluted but I don't think it is possible to simplify
the interactions with reasonable effort and within this patch set.
If things can be simplified, this needs to happen before or after the
vmstate conversion IMHO. I would like to keep the mantra no behavior changes
until patch 9 because otherwise it will get so complicated that I won't
feel comfortable myself.

Cheers,
Halil


>>  } ChannelSubSys;
>>  
>>

[..]
