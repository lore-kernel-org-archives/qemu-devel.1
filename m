Received: from eggs.gnu.org ([2001:4830:134:3::10]:41590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dLAEx-00067S-Hu
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dLAEs-0002wA-OG
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:29:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dLAEs-0002vW-Hp
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:29:46 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <4edcfe43-115c-ffa5-d63a-ffcabb0bfc6a@samsung.com> (Alexey
	Perevalov's message of "Wed, 14 Jun 2017 15:40:22 +0300")
References: <1497346593-8791-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170613093801eucas1p1e2b34c1a72b7150a28007d5b187da82e@eucas1p1.samsung.com>
	<1497346593-8791-3-git-send-email-a.perevalov@samsung.com>
	<87tw3kjer9.fsf@secure.mitica>
	<4edcfe43-115c-ffa5-d63a-ffcabb0bfc6a@samsung.com>
Reply-To: quintela@redhat.com
Date: Wed, 14 Jun 2017 17:29:39 +0200
Message-ID: <87fuf2egf0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 2/2] migration: add bitmap for copied
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, i.maximets@samsung.com, dgilbert@redhat.com

Alexey Perevalov <a.perevalov@samsung.com> wrote:
> On 06/13/2017 02:42 PM, Juan Quintela wrote:
>> Alexey Perevalov <a.perevalov@samsung.com> wrote:
>>
>> Hi
>>
>> I think that it would make things clearer if we do a s/copied/received/
>> As what we are tracking here are the pages that have already been
>> received.
>>
>>
>>> This patch adds ability to track down already copied
>>> pages, it's necessary for calculation vCPU block time in
>>> postcopy migration feature, maybe for restore after
>>> postcopy migration failure.
>>> Also it's necessary to solve shared memory issue in
>>> postcopy livemigration. Information about copied pages
>>> will be transferred to the software virtual bridge
>>> (e.g. OVS-VSWITCHD), to avoid fallocate (unmap) for
>>> already copied pages. fallocate syscall is required for
>>> remmaped shared memory, due to remmaping itself blocks
>>> ioctl(UFFDIO_COPY, ioctl in this case will end with EEXIT
>>> error (struct page is exists after remmap).
>>>
>>> Bitmap is placed into RAMBlock as another postcopy/precopy
>>> related bitmaps.
>> Why are we not using the TARGET_PAGE_SIZE as units of the bitmap?
>>
>>
>>> copied bitmap is not releasing due to ramblocks is not releasing
>>> too.
>> RAMBlocks are used for other reasons, not only migration.  This bitmaps
>> can be released on the ram_load_cleanup() function.  See my patches on
>> list about how to use it.
> I saw patch "migration: Convert ram to use new load_setup()/load_cleanup()",
> second version
>
> ram_load_cleanup - IIUC, calls as load_cleanup callback, from 2 use cases:
> 	1. QEMU_OPTION_loadvm
> 	2. hmp_loadvm
>
> in both cases: load_snapshot, qemu_loadvm_state,
> qemu_loadvm_state_cleanup, load_cleanup callback

Hi

Are you looking at v2?

On my tree:

int qemu_loadvm_state(QEMUFile *f)
{

....

    qemu_loadvm_state_cleanup();
    cpu_synchronize_all_post_init();

    return ret;
}

And everything that counts call qemu_loadvm_state() to load the state,
no?

Later, Juan.
