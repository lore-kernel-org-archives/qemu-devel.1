Received: from eggs.gnu.org ([2001:4830:134:3::10]:33490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d34Jd-000877-H1
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d34JZ-0001Dj-JY
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:31:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10201)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d34JZ-0001DR-C7
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:31:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBE6DD3C1A
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 17:31:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <2881bd24-5dbe-3714-c4bc-582950ccc125@redhat.com> (Laurent
	Vivier's message of "Tue, 25 Apr 2017 19:10:20 +0200")
References: <20170425102446.4008-1-quintela@redhat.com>
	<20170425102446.4008-7-quintela@redhat.com>
	<486c3746-e254-677d-7709-54670eafa6b0@redhat.com>
	<87inlsmng6.fsf@secure.mitica>
	<2881bd24-5dbe-3714-c4bc-582950ccc125@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 25 Apr 2017 19:31:42 +0200
Message-ID: <87efwgmm0x.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 6/6] migration: Pass Error ** argument to
 {save, load}_vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, peterx@redhat.com

Laurent Vivier <lvivier@redhat.com> wrote:
> On 25/04/2017 19:00, Juan Quintela wrote:
>> Laurent Vivier <lvivier@redhat.com> wrote:
>>> On 25/04/2017 12:24, Juan Quintela wrote:

>>>>  {
>>>> +    Error *err = NULL;
>>>> +
>>>>      if (replay_snapshot) {
>>>>          if (replay_mode == REPLAY_MODE_RECORD) {
>>>> -            if (save_vmstate(replay_snapshot) != 0) {
>>>> +            if (save_vmstate(replay_snapshot, &err) != 0) {
>>>>                  error_report("Could not create snapshot for icount record");
>>>>                  exit(1);
>>>>              }
>>>>          } else if (replay_mode == REPLAY_MODE_PLAY) {
>>>> -            if (load_vmstate(replay_snapshot) != 0) {
>>>> +            if (load_vmstate(replay_snapshot, &err) != 0) {
>>>>                  error_report("Could not load snapshot for icount replay");
>>>>                  exit(1);
>>>>              }
>>>
>>> You can use "&error_fatal" in these cases.
>> 
>> I was very happy with your suggestion.  But then I realized that if I
>> use error_fatal, I would lost the error_report() messages, right?
>
> The "Could not create snapshot for icount record" and "Could not load
> snapshot for icount replay", yes.
>
> But you keep the one from the inside load_vmstate().

    if (!bdrv_all_can_snapshot(&bs)) {
        error_setg(errp, "Device '%s' is writable but does not support "
                   "snapshots", bdrv_get_device_name(bs));
        return ret;
    }

This is the 1st error on save_vmstate.  My understanding is that now I
get something like (two messages):

Device 'foo' is writable but does not support snapshots
Could not create snapshot for icount record

If I change to error_fatal, only the 1st message will appear.  And I am
not replay maintainer to decide the change O:-)


> Isn't it enough?

Dunno.

Later, Juan.
