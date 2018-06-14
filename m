Received: from eggs.gnu.org ([2001:4830:134:3::10]:44892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fTIzv-0003Zu-3N
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 23:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fTIzq-00026z-5T
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 23:32:31 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:34691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fTIzp-00026p-Uq
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 23:32:26 -0400
Received: by mail-pf0-x230.google.com with SMTP id a63-v6so2494078pfl.1
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 20:32:25 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-3-xiaoguangrong@tencent.com>
	<20180613155147.GJ2676@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <8a88b788-bc3e-4806-04a4-13e5cf62fd44@gmail.com>
Date: Thu, 14 Jun 2018 11:32:17 +0800
MIME-Version: 1.0
In-Reply-To: <20180613155147.GJ2676@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/12] migration: fix counting normal page
 for compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 06/13/2018 11:51 PM, Dr. David Alan Gilbert wrote:
> * guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> The compressed page is not normal page
> 
> Is this the right reason?

I think the 'normal' page shouldn't include the compressed
page and XBZRLE-ed page (the current code does not treat
xbzrle pages are normal as well).

> I think we always increment some counter for a page - so
> what gets incremented for a compressed page?

In the later patch, we will introduce the statistics of
compression which contains "pages":
    @pages: amount of pages compressed and transferred to the target VM

> Is the real answer that we do:
> 
>    ram_save_target_page
>       control_save_page
>       compress_page_with_multi_thread
> 
> and control_save_page already increments the counter?

No :), control_save_page increments the counter only if it posted
data out, under that case, the compression path is not invoked.

Thanks!
