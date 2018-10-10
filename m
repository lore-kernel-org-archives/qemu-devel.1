Received: from eggs.gnu.org ([2001:4830:134:3::10]:41413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAJeu-0005s8-Ko
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAJer-0006lE-Fp
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:56:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gAJeq-0006ht-FX
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:56:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5909D83F44
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 18:56:24 +0000 (UTC)
References: <1539093025-101599-1-git-send-email-imammedo@redhat.com>
	<9ccf4afa-3528-a336-3eb2-9fc516852e91@redhat.com>
	<40220217-aa30-9436-22a8-9d1fca611d8e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <85084815-a668-c5f4-bd36-b4853596a658@redhat.com>
Date: Wed, 10 Oct 2018 20:56:21 +0200
MIME-Version: 1.0
In-Reply-To: <40220217-aa30-9436-22a8-9d1fca611d8e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: move MemoryRegion::size cleanup to
 memory_region_finalize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

On 09/10/2018 19:09, Laszlo Ersek wrote:
>>    memory_region_size() != 0
>> and therefore it's ok to access it in
>>    file_backend_unparent()
>>       if (memory_region_size() != 0)
>>           memory_region_get_ram_ptr()
>>
>> which happens when object_add fails and unparents failed backend making
>> file_backend_unparent() access invalid memory region.
>
> I think it makes sense to zero out the size even if unparenting
> would, in itself, prevent the above crash. Because, in
> host_memory_backend_mr_inited(), we have:
> 
>     /*
>      * NOTE: We forbid zero-length memory backend, so here zero means
>      * "we haven't inited the backend memory region yet".
>      */
> 
> I'm unsure how general that invariant is, but it can't hurt to honor
> it everywhere. (Especially if we can do the zeroing in one common
> place.)

Yeah, that's the part that I'm not sure about.  If we do it in finalize,
no one should be able to observe that we are zeroing it; finalize runs
just before the object is g_free-d.  I agree with Igor that it's nicer
to leave the object in good state, but the right place to zero is
exactly where the first patch placed it, i.e. where the error is
detected and the initialization of memory_region_init is unwound.

Paolo
