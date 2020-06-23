Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EB5C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 18:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999F12072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 18:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjVKgEqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999F12072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnnhJ-00038F-Rn
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 14:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnngX-0002ZS-NL
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 14:30:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40483
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnngU-0004xP-CE
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 14:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592937013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9j0wjDBbJSecBZH6f97BArBq7ORnlj3ZbRnja/csSOI=;
 b=bjVKgEqYvhOqp2/0mwtx0IRTiUa/vfQ9+uLlBzOv4P49djQIpCLXM3hOswVF44pjqwdOj8
 D28x3dYUemZf0MdC+o4hTYKxIitFN/eELaSLl/VXkjRxe5wGnOS0vpm2n2/wjpGN56GSNc
 ZgAggEsO2JIgwcuJATrYMkAJ+qEhmYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-MC6vZkB-OgWjC3vQEMIcmg-1; Tue, 23 Jun 2020 14:30:09 -0400
X-MC-Unique: MC6vZkB-OgWjC3vQEMIcmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3738F107AFB2;
 Tue, 23 Jun 2020 18:30:08 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B3B227CC9;
 Tue, 23 Jun 2020 18:30:05 +0000 (UTC)
Subject: Re: [PATCH 2/2] vvfat: Fix array_remove_slice()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200623175534.38286-1-kwolf@redhat.com>
 <20200623175534.38286-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ca89d6ae-734f-66b0-3862-e41ab4ce6455@redhat.com>
Date: Tue, 23 Jun 2020 13:30:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623175534.38286-3-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: nhuck15@gmail.com, qemu-devel@nongnu.org, ppandit@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 12:55 PM, Kevin Wolf wrote:
> array_remove_slice() calls array_roll() with array->next - 1 as the
> destination index. This is only correct for count == 1, otherwise we're
> writing past the end of the array. array->next - count would be correct.
> 
> However, this is the only place ever calling array_roll(), so this
> rather complicated operation isn't even necessary.
> 
> Fix the problem and simplify the code by replacing it with a single
> memmove() call. array_roll() can now be removed.
> 
> Reported-by: Nathan Huckleberry <nhuck15@gmail.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/vvfat.c | 42 +++++-------------------------------------
>   1 file changed, 5 insertions(+), 37 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 2fab371258..d6e464c595 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -140,48 +140,16 @@ static inline void* array_insert(array_t* array,unsigned int index,unsigned int
>       return array->pointer+index*array->item_size;
>   }
>   
> -/* this performs a "roll", so that the element which was at index_from becomes
> - * index_to, but the order of all other elements is preserved. */
> -static inline int array_roll(array_t* array,int index_to,int index_from,int count)

If I understand the intent from just the comment, the old code would 
take a directory listing of six files:

ABCDEF

and on the request to delete file C, would produce:

ABFDE

by moving just F, instead of all of DEF.  That might be what legacy FAT 
filesystems do natively, but I don't see it as a mandatory correctness 
issue; ABDEF is still a directory with the same contents.  And the bug 
for reading beyond array bounds when deleting more than one file is 
indeed nasty, so your simpler code is fine.

>   static inline int array_remove_slice(array_t* array,int index, int count)
>   {
>       assert(index >=0);
>       assert(count > 0);
>       assert(index + count <= array->next);
> -    if(array_roll(array,array->next-1,index,count))
> -        return -1;
> +
> +    memmove(array->pointer + index * array->item_size,
> +            array->pointer + (index + count) * array->item_size,
> +            (array->next - index - count) * array->item_size);
> +

Reviewed-by: Eric Blake <eblake@redhat.com>

>       array->next -= count;
>       return 0;
>   }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


