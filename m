Received: from eggs.gnu.org ([2001:4830:134:3::10]:33701)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cq0PB-0001Wa-87
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cq0P8-0007nZ-26
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:43:37 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:59704 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cq0P7-0007mn-PG
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:43:33 -0400
References: <bd7cb196-0779-42ad-ce9c-5871d307adce@kamp.de>
	<82d604c8-068a-aff4-6037-e3cd247b3588@redhat.com>
	<819af057-3777-dffc-4670-895b8265fd01@kamp.de>
	<d41d1428-4c8b-7e2f-b197-8d45b834776d@redhat.com>
	<32e1e781-f0b0-ac67-a5ce-74ccc64071a0@kamp.de>
	<20170320024649.GA18938@lemon.lan>
	<37879546-cf6e-01fa-adc6-c777e14eab0e@redhat.com>
	<20170320114926.GB17020@lemon.lan>
	<b3bf1d26-7caa-1d0d-c8a1-02f4c80e51e4@kamp.de>
	<fc755658-8d1d-db71-1f4d-2e18f5c3c4b2@kamp.de>
	<ff4b36e6-cf69-5b32-77b7-285adf4aaca0@redhat.com>
	<4aa3e0fc-1176-af7d-bef9-2b881a984605@kamp.de>
	<f0e9decf-7b92-9218-a43f-d7d6eee10208@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <a7b9b590-a0b5-5b2f-3efa-bfafefc5037c@kamp.de>
Date: Mon, 20 Mar 2017 17:43:30 +0100
MIME-Version: 1.0
In-Reply-To: <f0e9decf-7b92-9218-a43f-d7d6eee10208@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] callout to *file in bdrv_co_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

Am 20.03.2017 um 15:05 schrieb Paolo Bonzini:
>
> On 20/03/2017 14:35, Peter Lieven wrote:
>> Am 20.03.2017 um 14:23 schrieb Paolo Bonzini:
>>> On 20/03/2017 14:13, Peter Lieven wrote:
>>>> Am 20.03.2017 um 13:47 schrieb Peter Lieven:
>>>>> commit 5daa74a6ebce7543aaad178c4061dc087bb4c705
>>>>> Author: Paolo Bonzini <pbonzini@redhat.com>
>>>>> Date:   Wed Sep 4 19:00:38 2013 +0200
>>>>>
>>>>>     block: look for zero blocks in bs->file
>>>>>    
>>>>>     Reviewed-by: Eric Blake <eblake@redhat.com>
>>>>>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>>>     Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>
>>>>>
>>>>> It was introduced while introducing bdv_get_block_status. I don't know what the real
>>>>>
>>>>> issue was that was addressed with this patch?
>>>> Is it possible that this optimization was added especially for RAW? I was believing that
>>>> raw would forward the get_block_status call to bs->file, but it looks it doesn't.
>>>> If this one here was for RAW would it be an option to move this callout to the raw-format driver
>>>> and remove it from the generic code?
>>> It was meant for both raw and qcow2.
>> Okay, but as Fam mentioned qcow2 Metadata should know that a cluster is zero. Do you remember
>> what the issue was?
> I said that already---preallocated metadata.  Also, at the time
> pre-qcow2v3 was more important.

Yes, but Fam said that with preallocated metadata the clusters should be zero, or was that
not true before qcow2v3?

>
> Are you using libiscsi, block devices or files?

Its a mixture. raw with libiscsi or lvm and qcow2 and vmdk either with libnfs or on local storage.

I stumbled across the issue with lseek on a tmpfs because in the build process for our templates
I temporarily have vmdks on a tmpfs and it takes ages before qemu-img convert starts to run (it iterates
over every 64kb cluster with that callout to find_allocation and for some reason lseek is very slow on tmpfs).

Peter
