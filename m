Received: from eggs.gnu.org ([2001:4830:134:3::10]:44439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d3Jj9-0001RE-AF
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d3Jj4-0002Tr-BN
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:59:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1d3Jj3-0002TI-Ts
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:59:10 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3Q9wjt2058823
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 05:59:08 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebwaj4q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 05:59:08 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 26 Apr 2017 05:59:06 -0400
References: <70ef6f1f-27f4-133f-ab33-03a30f19867b@de.ibm.com>
	<20170424105344.GF2362@work-vm>
	<75a4c5ff-385e-31ac-5f86-883b082cd94e@de.ibm.com>
	<20170424143516.GD2075@work-vm>
	<5c0608dd-ba22-dc09-71a1-bb95c977f77d@de.ibm.com>
	<20170424191202.GQ2362@work-vm>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 26 Apr 2017 11:59:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170424191202.GQ2362@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <097a5085-1128-cf2d-abc4-54660a608f36@de.ibm.com>
Subject: Re: [Qemu-devel] postcopy migration hangs while loading virtio state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 04/24/2017 09:12 PM, Dr. David Alan Gilbert wrote:
> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
>> On 04/24/2017 04:35 PM, Dr. David Alan Gilbert wrote:
>>> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
>>>> On 04/24/2017 12:53 PM, Dr. David Alan Gilbert wrote:
>>>>> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
>>>>>> David, Juan,
>>>>>>
>>>>>> I can trigger a hang of postcopy migration (when I do it early) so
>>>>>> that both sides are in paused state. Looks like one thread is still
>>>>>> loading vmstates for virtio and this load accesses guest memory and
>>>>>> triggers a userfault.
>>>>>
>>>>> It's perfectly legal for the destination to cause a userfault as it
>>>>> loads the virtio queue - the virtio queue should be being loaded by
>>>>> the main thread from the buffer while the 'listening' thread is
>>>>> waiting for the incoming page data.
>>>>>
>>>>> Can you turn on the following tracing please: destination: 
>>>>> postcopy_ram_fault_thread_request postcopy_place_page 
>>>>> postcopy_place_page_zero
>>>>>
>>>>> source: migrate_handle_rp_req_pages ram_save_queue_pages
>>>>>
>>>>> You should see: virtio does the access userfault generates a fault 
>>>>> postcopy_ram_fault_thread_request sends the request to the source
>>>>>
>>>>> the source sees migrate_handle_rp_req_pages queues it with
>>>>> ram_save_queue_pages
>>>>>
>>>>> the destination sees the page arrive and postcopy_place_page or
>>>>> postcopy_place_page_zero
>>>>>
>>>>> some of that might disappear if the page was already on it's way.
>>>>
>>>>
>>>> the last event on the source are
>>>> [..]
>>>> 58412@1493037953.747988:postcopy_place_page host=0x3ff92246000
>>>> 58412@1493037953.747992:postcopy_place_page host=0x3ff92247000
>>>
>>> How do you see those on the source???
>>
>> It was the previous migrate (I did it in a loop forth and back)
>> The problem happens on the migrate back.
> 
> OK, good.
> 
>>>
>>>> 58412@1493037956.804210:migrate_handle_rp_req_pages in s390.ram at 41d9000 len 1000
>>>> 58412@1493037956.804216:ram_save_queue_pages s390.ram: start: 41d9000 len: 100
>>>>
>>>
>>> Is that a typo? I'm expecting those two 'len' fields to be the same?
>>
>> Yes, its a cut'n' paste "miss the last byte"
> 
> Good.
> 
> Ok, before digging further, is this a new bug or does it happen on older
> QEMU?  Have you got a rune to reproduce it on x86?
> 
>>
>>>
>>>> On the target a see lots of
>>>>
>>>> 39741@1493037958.833710:postcopy_place_page_zero host=0x3ff9befa000
>>>> 39741@1493037958.833716:postcopy_place_page host=0x3ff9befb000
>>>> 39741@1493037958.833759:postcopy_place_page host=0x3ff9befc000
>>>> 39741@1493037958.833818:postcopy_place_page host=0x3ff9befd000
>>>> 39741@1493037958.833819:postcopy_place_page_zero host=0x3ff9befe000
>>>> 39741@1493037958.833822:postcopy_place_page host=0x3ff9beff000
>>>>
>>>> So we have about 2 seconds of traffic going on after that request,
>>>> I assume its precopy related.
>>>>
>>>> Looking back on the target history there was
>>>> 39741@1493037956.804337:postcopy_ram_fault_thread_request Request for HVA=3ff618d9000 rb=s390.ram offset=41d9000
>>>>
>>>> In fact it seems to be the first and only request:
>>>>
>>>> # cat /tmp/test0.trace | grep -v postcopy_place_page
>>>>
>>>> 39741@1493037956.804337:postcopy_ram_fault_thread_request Request for HVA=3ff618d9000 rb=s390.ram offset=41d9000
>>>
>>> OK, does the HVA there correspond to the address that your virtio device is blocking on?
>>
>> yes it is the same page.
>>
>>
>>> (or at least the start of the page)
>>> Do you see a postcopy_place_page with a host= the same HVA ?
>>
>> no
> 
> Hmm, that's bad.
> The flow is:
>     Precopy
>        (a) Send pages
>     Switch to postcopy
>        (b) Send discards for pages that have been changed after
>            (a)
>     Postcopy
>        (c) Keep sending pages until we run out
>        (d) But send pages we're asked for first
> 
>  (d) might be ignored if the source thinks the page was already sent or not dirty.
> 
> So we need to figure out:
>   1) If the source sent the pages during (a)
>   2) If the source discarded it during (b)
>   3) If it sent it again any time in c/d
>   4) If it ignored the request from d
> 
> 
> So please turn on the traces:
>     get_queued_page_not_dirty                should help with (4)
>     get_queued_page                          should help with (4)
>     ram_discard_range                        should help with (2)
>     loadvm_postcopy_ram_handle_discard       should help with (2)
>     qemu_savevm_send_postcopy_ram_discard    should help with (2)
> 
> add near the top of ram_save_page in ram.c:
>   fprintf(stderr, "%s: %s:%zx\n", __func__, block->idstr, (size_t)offset);
> 
>    should help with 1, 3


source:
28863@1493200554.418978:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419047:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419056:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419064:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419071:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419077:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419083:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419088:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419094:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419100:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419106:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419112:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419117:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419123:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419130:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419138:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419145:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419151:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419156:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419163:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419169:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419174:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419179:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419184:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419189:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
28863@1493200554.419208:qemu_savevm_send_postcopy_ram_discard s390.ram: 9d
28863@1493200554.818195:migrate_handle_rp_req_pages in s390.ram at 3c6b000 len 1000
28863@1493200554.818208:ram_save_queue_pages s390.ram: start: 3c6b000 len: 1000
28863@1493200554.818469:get_queued_page_not_dirty s390.ram/3c6b000 ram_addr=3c6b000 (sent=0)

I also get 
ram_save_page: s390.ram:3c6b000


target (without postcopy_place)
10929@1493200553.657966:ram_discard_range s390.ram: start: 0 5dc00000
10929@1493200554.428226:loadvm_postcopy_ram_handle_discard 
10929@1493200554.428235:ram_discard_range s390.ram: start: 1000 a000
10929@1493200554.428247:ram_discard_range s390.ram: start: c000 4000
10929@1493200554.428252:ram_discard_range s390.ram: start: 12000 ee000
10929@1493200554.428441:ram_discard_range s390.ram: start: b72000 2000
10929@1493200554.428444:ram_discard_range s390.ram: start: b75000 2000
10929@1493200554.428447:ram_discard_range s390.ram: start: b79000 1000
10929@1493200554.428450:ram_discard_range s390.ram: start: b7e000 1000
10929@1493200554.428452:ram_discard_range s390.ram: start: b85000 1000
10929@1493200554.428455:ram_discard_range s390.ram: start: ba0000 1000
10929@1493200554.428457:ram_discard_range s390.ram: start: bad000 1000
10929@1493200554.428459:ram_discard_range s390.ram: start: bb7000 1000
10929@1493200554.428462:ram_discard_range s390.ram: start: bbe000 1000
10929@1493200554.428464:loadvm_postcopy_ram_handle_discard 
10929@1493200554.428465:ram_discard_range s390.ram: start: bc8000 1000
10929@1493200554.428468:ram_discard_range s390.ram: start: c16000 2000
10929@1493200554.428471:ram_discard_range s390.ram: start: ca3000 1000
10929@1493200554.428474:ram_discard_range s390.ram: start: cc3000 1000
10929@1493200554.428476:ram_discard_range s390.ram: start: cc9000 1000
10929@1493200554.428478:ram_discard_range s390.ram: start: ce9000 1000
10929@1493200554.428480:ram_discard_range s390.ram: start: cff000 1000
10929@1493200554.428483:ram_discard_range s390.ram: start: d05000 1000
10929@1493200554.428485:ram_discard_range s390.ram: start: d09000 6000
10929@1493200554.428491:ram_discard_range s390.ram: start: d11000 1000
10929@1493200554.428493:ram_discard_range s390.ram: start: d16000 1000
10929@1493200554.428496:ram_discard_range s390.ram: start: d1a000 1e000
10929@1493200554.428521:loadvm_postcopy_ram_handle_discard 
10929@1493200554.428522:ram_discard_range s390.ram: start: d39000 42000
10929@1493200554.428582:ram_discard_range s390.ram: start: d80000 3000
10929@1493200554.428587:ram_discard_range s390.ram: start: d84000 3000
10929@1493200554.428590:ram_discard_range s390.ram: start: d88000 2000
10929@1493200554.428593:ram_discard_range s390.ram: start: d8f000 1000
10929@1493200554.428596:ram_discard_range s390.ram: start: d91000 1000
10929@1493200554.428598:ram_discard_range s390.ram: start: d94000 1000
10929@1493200554.428600:ram_discard_range s390.ram: start: dbb000 1000
10929@1493200554.428603:ram_discard_range s390.ram: start: dbf000 7000
10929@1493200554.428610:ram_discard_range s390.ram: start: dc8000 1000
10929@1493200554.428612:ram_discard_range s390.ram: start: dca000 1000
10929@1493200554.428614:ram_discard_range s390.ram: start: dcd000 1000
10929@1493200554.428616:loadvm_postcopy_ram_handle_discard 
10929@1493200554.428617:ram_discard_range s390.ram: start: dd0000 5000
10929@1493200554.428623:ram_discard_range s390.ram: start: dd6000 7000
10929@1493200554.428630:ram_discard_range s390.ram: start: de0000 3000
10929@1493200554.428634:ram_discard_range s390.ram: start: de8000 3000
10929@1493200554.428637:ram_discard_range s390.ram: start: dec000 1000
10929@1493200554.428640:ram_discard_range s390.ram: start: dee000 12000
10929@1493200554.428655:ram_discard_range s390.ram: start: 1100000 2300000
10929@1493200554.437553:ram_discard_range s390.ram: start: 3423000 3000
10929@1493200554.437558:ram_discard_range s390.ram: start: 3475000 8b000
10929@1493200554.437697:ram_discard_range s390.ram: start: 35e3000 3000
10929@1493200554.437701:ram_discard_range s390.ram: start: 3600000 1000
10929@1493200554.437704:ram_discard_range s390.ram: start: 3606000 1000
10929@1493200554.437706:loadvm_postcopy_ram_handle_discard 
10929@1493200554.437707:ram_discard_range s390.ram: start: 360d000 1000
10929@1493200554.437709:ram_discard_range s390.ram: start: 3610000 1000
10929@1493200554.437711:ram_discard_range s390.ram: start: 3616000 1000
10929@1493200554.437713:ram_discard_range s390.ram: start: 361d000 1000
10929@1493200554.437716:ram_discard_range s390.ram: start: 3620000 1000
10929@1493200554.437726:ram_discard_range s390.ram: start: 3626000 1000
10929@1493200554.437729:ram_discard_range s390.ram: start: 362d000 1000
10929@1493200554.437731:ram_discard_range s390.ram: start: 3630000 1000
10929@1493200554.437734:ram_discard_range s390.ram: start: 3636000 1000
10929@1493200554.437736:ram_discard_range s390.ram: start: 363d000 1000
10929@1493200554.437738:ram_discard_range s390.ram: start: 3640000 1000
10929@1493200554.437740:ram_discard_range s390.ram: start: 3646000 1000
10929@1493200554.437742:loadvm_postcopy_ram_handle_discard 
10929@1493200554.437743:ram_discard_range s390.ram: start: 364d000 1000
10929@1493200554.437746:ram_discard_range s390.ram: start: 3650000 1000
10929@1493200554.437748:ram_discard_range s390.ram: start: 3656000 1000
10929@1493200554.437750:ram_discard_range s390.ram: start: 365d000 1000
10929@1493200554.437752:ram_discard_range s390.ram: start: 3660000 1000
10929@1493200554.437754:ram_discard_range s390.ram: start: 3666000 1000
10929@1493200554.437757:ram_discard_range s390.ram: start: 366d000 1000
10929@1493200554.437759:ram_discard_range s390.ram: start: 3670000 1000
10929@1493200554.437761:ram_discard_range s390.ram: start: 3676000 1000
10929@1493200554.437763:ram_discard_range s390.ram: start: 367d000 4000
10929@1493200554.437768:ram_discard_range s390.ram: start: 3686000 1000
10929@1493200554.437770:ram_discard_range s390.ram: start: 368d000 1000
10929@1493200554.437772:loadvm_postcopy_ram_handle_discard 
10929@1493200554.437773:ram_discard_range s390.ram: start: 3690000 1000
10929@1493200554.437775:ram_discard_range s390.ram: start: 3696000 1000
10929@1493200554.437778:ram_discard_range s390.ram: start: 369d000 1000
10929@1493200554.437780:ram_discard_range s390.ram: start: 36a0000 1000
10929@1493200554.437782:ram_discard_range s390.ram: start: 36a6000 1000
10929@1493200554.437784:ram_discard_range s390.ram: start: 36ad000 1000
10929@1493200554.437786:ram_discard_range s390.ram: start: 36b0000 1000
10929@1493200554.437789:ram_discard_range s390.ram: start: 36b6000 1000
10929@1493200554.437791:ram_discard_range s390.ram: start: 36bd000 1000
10929@1493200554.437793:ram_discard_range s390.ram: start: 36c0000 1000
10929@1493200554.437795:ram_discard_range s390.ram: start: 36c6000 1000
10929@1493200554.437798:ram_discard_range s390.ram: start: 36cd000 1000
10929@1493200554.437800:loadvm_postcopy_ram_handle_discard 
10929@1493200554.437801:ram_discard_range s390.ram: start: 36d0000 1000
10929@1493200554.437803:ram_discard_range s390.ram: start: 36d6000 1000
10929@1493200554.437805:ram_discard_range s390.ram: start: 36dd000 1000
10929@1493200554.437807:ram_discard_range s390.ram: start: 36e0000 1000
10929@1493200554.437810:ram_discard_range s390.ram: start: 36e6000 1000
10929@1493200554.437812:ram_discard_range s390.ram: start: 36ed000 1000
10929@1493200554.437814:ram_discard_range s390.ram: start: 36f0000 1000
10929@1493200554.437816:ram_discard_range s390.ram: start: 36f6000 1000
10929@1493200554.437819:ram_discard_range s390.ram: start: 36fd000 1000
10929@1493200554.437821:ram_discard_range s390.ram: start: 37e0000 1000
10929@1493200554.437824:ram_discard_range s390.ram: start: 37e6000 1000
10929@1493200554.437826:ram_discard_range s390.ram: start: 37ed000 1000
10929@1493200554.437828:loadvm_postcopy_ram_handle_discard 
10929@1493200554.437829:ram_discard_range s390.ram: start: 37f0000 1000
10929@1493200554.437831:ram_discard_range s390.ram: start: 37f6000 1000
10929@1493200554.437833:ram_discard_range s390.ram: start: 37fd000 1000
10929@1493200554.437836:ram_discard_range s390.ram: start: 3800000 1000
10929@1493200554.437838:ram_discard_range s390.ram: start: 3806000 1000
10929@1493200554.437840:ram_discard_range s390.ram: start: 380d000 1000
10929@1493200554.437842:ram_discard_range s390.ram: start: 3810000 1000
10929@1493200554.437845:ram_discard_range s390.ram: start: 3816000 1000
10929@1493200554.437847:ram_discard_range s390.ram: start: 381d000 3000
10929@1493200554.437850:ram_discard_range s390.ram: start: 3850000 1000
10929@1493200554.437854:ram_discard_range s390.ram: start: 3856000 1000
10929@1493200554.437858:ram_discard_range s390.ram: start: 385d000 1000
10929@1493200554.437860:loadvm_postcopy_ram_handle_discard 
10929@1493200554.437861:ram_discard_range s390.ram: start: 3860000 1000
10929@1493200554.437863:ram_discard_range s390.ram: start: 3866000 1000
10929@1493200554.437865:ram_discard_range s390.ram: start: 386d000 1000
10929@1493200554.437868:ram_discard_range s390.ram: start: 3870000 1000
10929@1493200554.437870:ram_discard_range s390.ram: start: 3876000 1000
10929@1493200554.437872:ram_discard_range s390.ram: start: 387d000 1000
10929@1493200554.437874:ram_discard_range s390.ram: start: 3880000 1000
10929@1493200554.437877:ram_discard_range s390.ram: start: 3886000 1000
10929@1493200554.437879:ram_discard_range s390.ram: start: 388d000 1000
10929@1493200554.437881:ram_discard_range s390.ram: start: 3890000 1000
10929@1493200554.437883:ram_discard_range s390.ram: start: 3896000 1000
10929@1493200554.437885:ram_discard_range s390.ram: start: 389d000 1000
10929@1493200554.437887:loadvm_postcopy_ram_handle_discard 
10929@1493200554.437888:ram_discard_range s390.ram: start: 38a0000 1000
10929@1493200554.437891:ram_discard_range s390.ram: start: 38a6000 1000
10929@1493200554.437893:ram_discard_range s390.ram: start: 38ad000 1000
10929@1493200554.437895:ram_discard_range s390.ram: start: 38b0000 1000
10929@1493200554.437897:ram_discard_range s390.ram: start: 38b6000 1000
10929@1493200554.437899:ram_discard_range s390.ram: start: 38bd000 1000
10929@1493200554.437902:ram_discard_range s390.ram: start: 38c0000 1000
10929@1493200554.437904:ram_discard_range s390.ram: start: 38c6000 1000
10929@1493200554.437906:ram_discard_range s390.ram: start: 38cd000 1000
10929@1493200554.437908:ram_discard_range s390.ram: start: 38d0000 1000
10929@1493200554.437911:ram_discard_range s390.ram: start: 38d6000 1000
10929@1493200554.437913:ram_discard_range s390.ram: start: 38dd000 1000
10929@1493200554.437915:loadvm_postcopy_ram_handle_discard 
10929@1493200554.437916:ram_discard_range s390.ram: start: 38e0000 1000
10929@1493200554.437919:ram_discard_range s390.ram: start: 38e6000 1000
10929@1493200554.437921:ram_discard_range s390.ram: start: 38ed000 3000
10929@1493200554.437925:ram_discard_range s390.ram: start: 3900000 1000
10929@1493200554.437927:ram_discard_range s390.ram: start: 3906000 1000
10929@1493200554.437930:ram_discard_range s390.ram: start: 390d000 1000
10929@1493200554.437932:ram_discard_range s390.ram: start: 3920000 1000
10929@1493200554.437934:ram_discard_range s390.ram: start: 3922000 1000
10929@1493200554.437936:ram_discard_range s390.ram: start: 3924000 1000
10929@1493200554.437938:ram_discard_range s390.ram: start: 3926000 1000
10929@1493200554.437941:ram_discard_range s390.ram: start: 392b000 1000
10929@1493200554.437943:ram_discard_range s390.ram: start: 3930000 1000
10929@1493200554.437945:loadvm_postcopy_ram_handle_discard 
10929@1493200554.437946:ram_discard_range s390.ram: start: 3936000 1000
10929@1493200554.437948:ram_discard_range s390.ram: start: 393d000 1000
10929@1493200554.437950:ram_discard_range s390.ram: start: 3940000 1000
10929@1493200554.437953:ram_discard_range s390.ram: start: 3946000 1000
10929@1493200554.437955:ram_discard_range s390.ram: start: 394d000 1000
10929@1493200554.437957:ram_discard_range s390.ram: start: 3950000 1000
10929@1493200554.437960:ram_discard_range s390.ram: start: 3956000 1000
10929@1493200554.437962:ram_discard_range s390.ram: start: 395d000 1000
10929@1493200554.437964:ram_discard_range s390.ram: start: 3960000 1000
10929@1493200554.437966:ram_discard_range s390.ram: start: 3966000 1000
10929@1493200554.437969:ram_discard_range s390.ram: start: 396d000 1000
10929@1493200554.437971:ram_discard_range s390.ram: start: 3970000 1000
10929@1493200554.437973:loadvm_postcopy_ram_handle_discard 
10929@1493200554.437974:ram_discard_range s390.ram: start: 3976000 1000
10929@1493200554.437976:ram_discard_range s390.ram: start: 397d000 1000
10929@1493200554.437978:ram_discard_range s390.ram: start: 3980000 1000
10929@1493200554.437981:ram_discard_range s390.ram: start: 3986000 1000
10929@1493200554.437984:ram_discard_range s390.ram: start: 398d000 1000
10929@1493200554.437986:ram_discard_range s390.ram: start: 3990000 1000
10929@1493200554.437988:ram_discard_range s390.ram: start: 3996000 1000
10929@1493200554.437990:ram_discard_range s390.ram: start: 399d000 3000
10929@1493200554.437994:ram_discard_range s390.ram: start: 39ad000 8000
10929@1493200554.438002:ram_discard_range s390.ram: start: 39c8000 1000
10929@1493200554.438004:ram_discard_range s390.ram: start: 39ca000 1000
10929@1493200554.438006:ram_discard_range s390.ram: start: 39cc000 1000
10929@1493200554.438008:loadvm_postcopy_ram_handle_discard 
10929@1493200554.438009:ram_discard_range s390.ram: start: 39ce000 1000
10929@1493200554.438011:ram_discard_range s390.ram: start: 39e0000 1000
10929@1493200554.438014:ram_discard_range s390.ram: start: 39e6000 1000
10929@1493200554.438016:ram_discard_range s390.ram: start: 39ed000 1000
10929@1493200554.438018:ram_discard_range s390.ram: start: 39f0000 1000
10929@1493200554.438021:ram_discard_range s390.ram: start: 39f6000 1000
10929@1493200554.438023:ram_discard_range s390.ram: start: 39fd000 1000
10929@1493200554.438025:ram_discard_range s390.ram: start: 3a00000 1000
10929@1493200554.438027:ram_discard_range s390.ram: start: 3a06000 1000
10929@1493200554.438029:ram_discard_range s390.ram: start: 3a0d000 1000
10929@1493200554.438031:ram_discard_range s390.ram: start: 3a10000 1000
10929@1493200554.438034:ram_discard_range s390.ram: start: 3a16000 1000
10929@1493200554.438036:loadvm_postcopy_ram_handle_discard 
10929@1493200554.438037:ram_discard_range s390.ram: start: 3a1d000 1000
10929@1493200554.438039:ram_discard_range s390.ram: start: 3a20000 1000
10929@1493200554.438041:ram_discard_range s390.ram: start: 3a26000 1000
10929@1493200554.438043:ram_discard_range s390.ram: start: 3a2d000 1000
10929@1493200554.438045:ram_discard_range s390.ram: start: 3a30000 1000
10929@1493200554.438048:ram_discard_range s390.ram: start: 3a36000 1000
10929@1493200554.438050:ram_discard_range s390.ram: start: 3a3d000 1000
10929@1493200554.438052:ram_discard_range s390.ram: start: 3a40000 1000
10929@1493200554.438054:ram_discard_range s390.ram: start: 3a46000 1000
10929@1493200554.438056:ram_discard_range s390.ram: start: 3a4d000 1000
10929@1493200554.438059:ram_discard_range s390.ram: start: 3a50000 1000
10929@1493200554.438061:ram_discard_range s390.ram: start: 3a56000 1000
10929@1493200554.438063:loadvm_postcopy_ram_handle_discard 
10929@1493200554.438067:ram_discard_range s390.ram: start: 3a5d000 1000
10929@1493200554.438069:ram_discard_range s390.ram: start: 3a60000 1000
10929@1493200554.438071:ram_discard_range s390.ram: start: 3a66000 1000
10929@1493200554.438073:ram_discard_range s390.ram: start: 3a6d000 1000
10929@1493200554.438075:ram_discard_range s390.ram: start: 3a70000 1000
10929@1493200554.438078:ram_discard_range s390.ram: start: 3a76000 1000
10929@1493200554.438080:ram_discard_range s390.ram: start: 3a7d000 4000
10929@1493200554.438084:ram_discard_range s390.ram: start: 3a86000 1000
10929@1493200554.438087:ram_discard_range s390.ram: start: 3a8d000 1000
10929@1493200554.438089:ram_discard_range s390.ram: start: 3a90000 1000
10929@1493200554.438091:ram_discard_range s390.ram: start: 3a96000 1000
10929@1493200554.438093:ram_discard_range s390.ram: start: 3a9d000 1000
10929@1493200554.438095:loadvm_postcopy_ram_handle_discard 
10929@1493200554.438096:ram_discard_range s390.ram: start: 3aa0000 1000
10929@1493200554.438098:ram_discard_range s390.ram: start: 3aa6000 1000
10929@1493200554.438100:ram_discard_range s390.ram: start: 3aad000 1000
10929@1493200554.438103:ram_discard_range s390.ram: start: 3ab0000 1000
10929@1493200554.438105:ram_discard_range s390.ram: start: 3ab6000 1000
10929@1493200554.438107:ram_discard_range s390.ram: start: 3abd000 1000
10929@1493200554.438109:ram_discard_range s390.ram: start: 3ac0000 1000
10929@1493200554.438111:ram_discard_range s390.ram: start: 3ac6000 1000
10929@1493200554.438114:ram_discard_range s390.ram: start: 3acd000 1000
10929@1493200554.438116:ram_discard_range s390.ram: start: 3ad0000 1000
10929@1493200554.438119:ram_discard_range s390.ram: start: 3ad6000 1000
10929@1493200554.438121:ram_discard_range s390.ram: start: 3add000 1000
10929@1493200554.438123:loadvm_postcopy_ram_handle_discard 
10929@1493200554.438124:ram_discard_range s390.ram: start: 3ae0000 1000
10929@1493200554.438126:ram_discard_range s390.ram: start: 3ae6000 1000
10929@1493200554.438128:ram_discard_range s390.ram: start: 3aed000 1000
10929@1493200554.438131:ram_discard_range s390.ram: start: 3af0000 1000
10929@1493200554.438133:ram_discard_range s390.ram: start: 3af6000 1000
10929@1493200554.438135:ram_discard_range s390.ram: start: 3afd000 1000
10929@1493200554.438137:ram_discard_range s390.ram: start: 3b00000 1000
10929@1493200554.438140:ram_discard_range s390.ram: start: 3b06000 1000
10929@1493200554.438142:ram_discard_range s390.ram: start: 3b0d000 1000
10929@1493200554.438144:ram_discard_range s390.ram: start: 3b10000 1000
10929@1493200554.438146:ram_discard_range s390.ram: start: 3b16000 1000
10929@1493200554.438149:ram_discard_range s390.ram: start: 3b1d000 4000
10929@1493200554.438154:loadvm_postcopy_ram_handle_discard 
10929@1493200554.438155:ram_discard_range s390.ram: start: 3b26000 1000
10929@1493200554.438157:ram_discard_range s390.ram: start: 3b2d000 1000
10929@1493200554.438160:ram_discard_range s390.ram: start: 3b30000 1000
10929@1493200554.438162:ram_discard_range s390.ram: start: 3b36000 1000
10929@1493200554.438164:ram_discard_range s390.ram: start: 3b3d000 1000
10929@1493200554.438166:ram_discard_range s390.ram: start: 3b40000 1000
10929@1493200554.438168:ram_discard_range s390.ram: start: 3b46000 1000
10929@1493200554.438170:ram_discard_range s390.ram: start: 3b4d000 1000
10929@1493200554.438173:ram_discard_range s390.ram: start: 3b50000 1000
10929@1493200554.438175:ram_discard_range s390.ram: start: 3b56000 1000
10929@1493200554.438177:ram_discard_range s390.ram: start: 3b5d000 1000
10929@1493200554.438179:ram_discard_range s390.ram: start: 3b60000 1000
10929@1493200554.438181:loadvm_postcopy_ram_handle_discard 
10929@1493200554.438182:ram_discard_range s390.ram: start: 3b66000 1000
10929@1493200554.438184:ram_discard_range s390.ram: start: 3b6d000 1000
10929@1493200554.438187:ram_discard_range s390.ram: start: 3b70000 1000
10929@1493200554.438189:ram_discard_range s390.ram: start: 3b76000 1000
10929@1493200554.438191:ram_discard_range s390.ram: start: 3b7d000 1000
10929@1493200554.438193:ram_discard_range s390.ram: start: 3b80000 1000
10929@1493200554.438196:ram_discard_range s390.ram: start: 3b86000 1000
10929@1493200554.438198:ram_discard_range s390.ram: start: 3b8d000 1000
10929@1493200554.438200:ram_discard_range s390.ram: start: 3b90000 1000
10929@1493200554.438202:ram_discard_range s390.ram: start: 3b96000 1000
10929@1493200554.438204:ram_discard_range s390.ram: start: 3b9d000 1000
10929@1493200554.438206:ram_discard_range s390.ram: start: 3ba0000 1000
10929@1493200554.438209:loadvm_postcopy_ram_handle_discard 
10929@1493200554.438210:ram_discard_range s390.ram: start: 3ba6000 1000
10929@1493200554.438212:ram_discard_range s390.ram: start: 3bad000 3000
10929@1493200554.438215:ram_discard_range s390.ram: start: 3bd0000 1000
10929@1493200554.438218:ram_discard_range s390.ram: start: 3bd6000 1000
10929@1493200554.438220:ram_discard_range s390.ram: start: 3bdd000 1000
10929@1493200554.438222:ram_discard_range s390.ram: start: 3be0000 1000
10929@1493200554.438224:ram_discard_range s390.ram: start: 3be6000 1000
10929@1493200554.438226:ram_discard_range s390.ram: start: 3bed000 1000
10929@1493200554.438229:ram_discard_range s390.ram: start: 3bf0000 1000
10929@1493200554.438231:ram_discard_range s390.ram: start: 3bf6000 1000
10929@1493200554.438233:ram_discard_range s390.ram: start: 3bfd000 1000
10929@1493200554.438235:ram_discard_range s390.ram: start: 3c06000 4000
10929@1493200554.438240:loadvm_postcopy_ram_handle_discard 
10929@1493200554.438241:ram_discard_range s390.ram: start: 3c79000 3000
10929@1493200554.438246:ram_discard_range s390.ram: start: 3c80000 1000
10929@1493200554.438248:ram_discard_range s390.ram: start: 3c86000 1000
10929@1493200554.438251:ram_discard_range s390.ram: start: 3c8d000 1000
10929@1493200554.438253:ram_discard_range s390.ram: start: 3c90000 1000
10929@1493200554.438255:ram_discard_range s390.ram: start: 3c96000 1000
10929@1493200554.438257:ram_discard_range s390.ram: start: 3c9d000 1000
10929@1493200554.438259:ram_discard_range s390.ram: start: 3ca0000 1000
10929@1493200554.438261:ram_discard_range s390.ram: start: 3ca6000 1000
10929@1493200554.438264:ram_discard_range s390.ram: start: 3cad000 1000
10929@1493200554.438266:ram_discard_range s390.ram: start: 3cb0000 1000
10929@1493200554.438268:ram_discard_range s390.ram: start: 3cb6000 1000
10929@1493200554.438270:loadvm_postcopy_ram_handle_discard 
10929@1493200554.438271:ram_discard_range s390.ram: start: 3cbd000 1000
10929@1493200554.438274:ram_discard_range s390.ram: start: 3cc0000 1000
10929@1493200554.438276:ram_discard_range s390.ram: start: 3cc6000 1000
10929@1493200554.438278:ram_discard_range s390.ram: start: 3ccd000 1000
10929@1493200554.438281:ram_discard_range s390.ram: start: 3cd0000 1000
10929@1493200554.438283:ram_discard_range s390.ram: start: 3cd6000 1000
10929@1493200554.438285:ram_discard_range s390.ram: start: 3cdd000 1000
10929@1493200554.438287:ram_discard_range s390.ram: start: 3ce0000 1000
10929@1493200554.438289:ram_discard_range s390.ram: start: 3ce6000 1000
10929@1493200554.438292:ram_discard_range s390.ram: start: 3ced000 1000
10929@1493200554.438294:ram_discard_range s390.ram: start: 3cf0000 1000
10929@1493200554.438296:ram_discard_range s390.ram: start: 3cf6000 1000
10929@1493200554.438298:loadvm_postcopy_ram_handle_discard 
10929@1493200554.438299:ram_discard_range s390.ram: start: 3cfd000 1000
10929@1493200554.438301:ram_discard_range s390.ram: start: 3d55000 2000
10929@1493200554.438304:ram_discard_range s390.ram: start: 3da3000 5000
10929@1493200554.438310:ram_discard_range s390.ram: start: 3dc0000 13000
10929@1493200554.438326:ram_discard_range s390.ram: start: 3dd4000 f000
10929@1493200554.438339:ram_discard_range s390.ram: start: 3de4000 3000
10929@1493200554.438343:ram_discard_range s390.ram: start: 3de8000 1000
10929@1493200554.438345:ram_discard_range s390.ram: start: 3dea000 1000
10929@1493200554.438347:ram_discard_range s390.ram: start: 3f4a000 1e000
10929@1493200554.438372:ram_discard_range s390.ram: start: 3fa8000 2000
10929@1493200554.438375:ram_discard_range s390.ram: start: 4000000 1000
10929@1493200554.438377:ram_discard_range s390.ram: start: 4006000 1000
10929@1493200554.438379:loadvm_postcopy_ram_handle_discard 
10929@1493200554.438380:ram_discard_range s390.ram: start: 400d000 1000
10929@1493200554.438383:ram_discard_range s390.ram: start: 4010000 1000
10929@1493200554.438385:ram_discard_range s390.ram: start: 4016000 1000
10929@1493200554.438387:ram_discard_range s390.ram: start: 401d000 3000
10929@1493200554.438391:ram_discard_range s390.ram: start: 4040000 1000
10929@1493200554.438393:ram_discard_range s390.ram: start: 4042000 1000
10929@1493200554.438395:ram_discard_range s390.ram: start: 40e3000 1000
10929@1493200554.438397:ram_discard_range s390.ram: start: 417e000 2215000
10929@1493200554.445269:ram_discard_range s390.ram: start: 2258d000 3b673000
10929@1493200554.817596:postcopy_ram_fault_thread_request Request for HVA=3ff3df6b000 rb=s390.ram offset=3c6b000


> 
> So lets see if your page ever gets sent in ram_save_page, and does it get
> discarded prior to it hitting the point where it hangs but after the page
> arrived?
> Another (slimmer) possibility is the number of dirties paged is wrong
> so the source thinks it has finished too soon - but we'll only look at
> that if all the above doesn't help.
> 
> Dave
> 
>>>
>>> From the source backtrace, I think the source thinks it's sent everything
>>> and is waiting for the return-path-thread to close.
>>>
>>> Dave
>>>
>>>>>
>>>>> Dave
>>>>>
>>>>>> Thread 1 (Thread 0x3ffa2f45f00 (LWP 21122)): #0  0x0000000001017130
>>>>>> in lduw_he_p (ptr=0x3ff498d9002) at
>>>>>> /root/qemu/include/qemu/bswap.h:317 <---- according to the host
>>>>>> kernel this threads hangs in handle_userfault. #1
>>>>>> 0x0000000001017342 in lduw_le_p (ptr=0x3ff498d9002) at
>>>>>> /root/qemu/include/qemu/bswap.h:359 #2  0x0000000001025840 in
>>>>>> address_space_lduw_internal_cached (cache=0x283491d0, addr=2,
>>>>>> attrs=..., result=0x0, endian=DEVICE_LITTLE_ENDIAN) at
>>>>>> /root/qemu/memory_ldst.inc.c:284 #3  0x00000000010259a6 in
>>>>>> address_space_lduw_le_cached (cache=0x283491d0, addr=2, attrs=...,
>>>>>> result=0x0) at /root/qemu/memory_ldst.inc.c:315 #4
>>>>>> 0x0000000001025ad6 in lduw_le_phys_cached (cache=0x283491d0,
>>>>>> addr=2) at /root/qemu/memory_ldst.inc.c:334 #5  0x0000000001116c10
>>>>>> in virtio_lduw_phys_cached (vdev=0x28275090, cache=0x283491d0,
>>>>>> pa=2) at /root/qemu/include/hw/virtio/virtio-access.h:166 #6
>>>>>> 0x0000000001117940 in vring_used_idx (vq=0x3ffa2e1c090) at
>>>>>> /root/qemu/hw/virtio/virtio.c:263 #7  0x000000000111daea in
>>>>>> virtio_load (vdev=0x28275090, f=0x28353600, version_id=2) at
>>>>>> /root/qemu/hw/virtio/virtio.c:2168 #8  0x000000000111d0cc in
>>>>>> virtio_device_get (f=0x28353600, opaque=0x28275090, size=0,
>>>>>> field=0x16adf38 <__compound_literal.0>) at
>>>>>> /root/qemu/hw/virtio/virtio.c:1975 #9  0x00000000012a7f50 in
>>>>>> vmstate_load_state (f=0x28353600, vmsd=0x14db480
>>>>>> <vmstate_virtio_blk>, opaque=0x28275090, version_id=2) at
>>>>>> /root/qemu/migration/vmstate.c:128 #10 0x00000000010cbc08 in
>>>>>> vmstate_load (f=0x28353600, se=0x28279e60, version_id=2) at
>>>>>> /root/qemu/migration/savevm.c:732 #11 0x00000000010ced6e in
>>>>>> qemu_loadvm_section_start_full (f=0x28353600, mis=0x17169a8
>>>>>> <mis_current>) at /root/qemu/migration/savevm.c:1890 #12
>>>>>> 0x00000000010cf00c in qemu_loadvm_state_main (f=0x28353600,
>>>>>> mis=0x17169a8 <mis_current>) at /root/qemu/migration/savevm.c:1947 
>>>>>> #13 0x00000000010ce5bc in loadvm_handle_cmd_packaged (mis=0x17169a8
>>>>>> <mis_current>) at /root/qemu/migration/savevm.c:1707 #14
>>>>>> 0x00000000010ce87e in loadvm_process_command (f=0x282c7d20) at
>>>>>> /root/qemu/migration/savevm.c:1770 #15 0x00000000010cf056 in
>>>>>> qemu_loadvm_state_main (f=0x282c7d20, mis=0x17169a8 <mis_current>)
>>>>>> at /root/qemu/migration/savevm.c:1960 #16 0x00000000010cf2b6 in
>>>>>> qemu_loadvm_state (f=0x282c7d20) at
>>>>>> /root/qemu/migration/savevm.c:2020 #17 0x000000000129d234 in
>>>>>> process_incoming_migration_co (opaque=0x282c7d20) at
>>>>>> /root/qemu/migration/migration.c:404 #18 0x00000000014b6ca2 in
>>>>>> coroutine_trampoline (i0=0, i1=674533168) at
>>>>>> /root/qemu/util/coroutine-ucontext.c:79 #19 0x000003ff8de530ea in
>>>>>> __makecontext_ret () from target:/lib64/libc.so.6
>>>>>>
>>>>>> Thread 8 (Thread 0x3ff40b38910 (LWP 21165)): #0  0x000003ff8df04336
>>>>>> in syscall () from target:/lib64/libc.so.6 #1  0x00000000014933ce
>>>>>> in qemu_futex_wait (f=0x17169b0 <mis_current+8>, val=4294967295) at
>>>>>> /root/qemu/include/qemu/futex.h:26 #2  0x00000000014935d0 in
>>>>>> qemu_event_wait (ev=0x17169b0 <mis_current+8>) at
>>>>>> /root/qemu/util/qemu-thread-posix.c:399 #3  0x00000000010ce094 in
>>>>>> postcopy_ram_listen_thread (opaque=0x282c7d20) at
>>>>>> /root/qemu/migration/savevm.c:1532 #4  0x000003ff8e007bc4 in
>>>>>> start_thread () from target:/lib64/libpthread.so.0 #5
>>>>>> 0x000003ff8df0a9f2 in thread_start () from target:/lib64/libc.so.6
>>>>>>
>>>>>> Thread 7 (Thread 0x3ff41338910 (LWP 21164)): #0  0x000003ff8defd72c
>>>>>> in ?? () from target:/lib64/libc.so.6 #1  0x00000000012af920 in
>>>>>> postcopy_ram_fault_thread (opaque=0x17169a8 <mis_current>) at
>>>>>> /root/qemu/migration/postcopy-ram.c:437 #2  0x000003ff8e007bc4 in
>>>>>> start_thread () from target:/lib64/libpthread.so.0 #3
>>>>>> 0x000003ff8df0a9f2 in thread_start () from target:/lib64/libc.so.6
>>>>>>
>>>>>> Thread 6 (Thread 0x3ff41b38910 (LWP 21163)): #0  0x000003ff8e00d450
>>>>>> in pthread_cond_wait@@GLIBC_2.3.2 () from
>>>>>> target:/lib64/libpthread.so.0 #1  0x0000000001492d66 in
>>>>>> qemu_cond_wait (cond=0x28302408, mutex=0x283023e0) at
>>>>>> /root/qemu/util/qemu-thread-posix.c:133 #2  0x00000000010c6080 in
>>>>>> do_data_decompress (opaque=0x283023d8) at
>>>>>> /root/qemu/migration/ram.c:2277 #3  0x000003ff8e007bc4 in
>>>>>> start_thread () from target:/lib64/libpthread.so.0 #4
>>>>>> 0x000003ff8df0a9f2 in thread_start () from target:/lib64/libc.so.6
>>>>>>
>>>>>> Thread 5 (Thread 0x3ff42338910 (LWP 21162)): #0  0x000003ff8e00d450
>>>>>> in pthread_cond_wait@@GLIBC_2.3.2 () from
>>>>>> target:/lib64/libpthread.so.0 #1  0x0000000001492d66 in
>>>>>> qemu_cond_wait (cond=0x28302390, mutex=0x28302368) at
>>>>>> /root/qemu/util/qemu-thread-posix.c:133 #2  0x00000000010c6080 in
>>>>>> do_data_decompress (opaque=0x28302360) at
>>>>>> /root/qemu/migration/ram.c:2277 #3  0x000003ff8e007bc4 in
>>>>>> start_thread () from target:/lib64/libpthread.so.0 #4
>>>>>> 0x000003ff8df0a9f2 in thread_start () from target:/lib64/libc.so.6
>>>>>>
>>>>>> Thread 4 (Thread 0x3ff89287910 (LWP 21148)): #0  0x000003ff8e010abc
>>>>>> in __lll_lock_wait () from target:/lib64/libpthread.so.0 #1
>>>>>> 0x000003ff8e00bcb6 in __pthread_mutex_cond_lock () from
>>>>>> target:/lib64/libpthread.so.0 #2  0x000003ff8e00d4ee in
>>>>>> pthread_cond_wait@@GLIBC_2.3.2 () from
>>>>>> target:/lib64/libpthread.so.0 #3  0x0000000001492d66 in
>>>>>> qemu_cond_wait (cond=0x2831eb00, mutex=0x1711688
>>>>>> <qemu_global_mutex>) at /root/qemu/util/qemu-thread-posix.c:133 #4
>>>>>> 0x000000000107720e in qemu_kvm_wait_io_event (cpu=0x282e09b0) at
>>>>>> /root/qemu/cpus.c:1085 #5  0x00000000010773aa in
>>>>>> qemu_kvm_cpu_thread_fn (arg=0x282e09b0) at /root/qemu/cpus.c:1123 
>>>>>> #6  0x000003ff8e007bc4 in start_thread () from
>>>>>> target:/lib64/libpthread.so.0 #7  0x000003ff8df0a9f2 in
>>>>>> thread_start () from target:/lib64/libc.so.6
>>>>>>
>>>>>> Thread 3 (Thread 0x3ff8a7ff910 (LWP 21145)): #0  0x000003ff8defd832
>>>>>> in ppoll () from target:/lib64/libc.so.6 #1  0x000000000148b092 in
>>>>>> qemu_poll_ns (fds=0x3ff840008c0, nfds=1, timeout=-1) at
>>>>>> /root/qemu/util/qemu-timer.c:322 #2  0x000000000148f46a in aio_poll
>>>>>> (ctx=0x2827e7b0, blocking=true) at /root/qemu/util/aio-posix.c:622 
>>>>>> #3  0x00000000011a78f6 in iothread_run (opaque=0x2827d740) at
>>>>>> /root/qemu/iothread.c:59 #4  0x000003ff8e007bc4 in start_thread ()
>>>>>> from target:/lib64/libpthread.so.0 #5  0x000003ff8df0a9f2 in
>>>>>> thread_start () from target:/lib64/libc.so.6
>>>>>>
>>>>>> Thread 2 (Thread 0x3ff8afff910 (LWP 21142)): #0  0x000003ff8df04336
>>>>>> in syscall () from target:/lib64/libc.so.6 #1  0x00000000014933ce
>>>>>> in qemu_futex_wait (f=0x1b2b9b4 <rcu_call_ready_event>,
>>>>>> val=4294967295) at /root/qemu/include/qemu/futex.h:26 #2
>>>>>> 0x00000000014935d0 in qemu_event_wait (ev=0x1b2b9b4
>>>>>> <rcu_call_ready_event>) at /root/qemu/util/qemu-thread-posix.c:399 
>>>>>> #3  0x00000000014b3e40 in call_rcu_thread (opaque=0x0) at
>>>>>> /root/qemu/util/rcu.c:249 #4  0x000003ff8e007bc4 in start_thread ()
>>>>>> from target:/lib64/libpthread.so.0 #5  0x000003ff8df0a9f2 in
>>>>>> thread_start () from target:/lib64/libc.so.6
>>>>>>
>>>>>>
>>>>>> Looks like that this <qemu:arg value='-drive'/> <qemu:arg
>>>>>> value='driver=null-aio,id=null1,if=none,size=100G'/> <qemu:arg
>>>>>> value='-device'/> <qemu:arg
>>>>>> value='virtio-blk-ccw,scsi=off,drive=null1,serial=null1,num-queues=4'/>
>>>>>>
>>>>>>
>>>>>> is necessary to trigger the hang, with nun-qeues=1 everything seems to work fine, so it might
>>>>>> be a virtio issue after all?
>>>>>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
