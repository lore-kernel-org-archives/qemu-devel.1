Received: from eggs.gnu.org ([2001:4830:134:3::10]:51658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cJ4Pc-0004rP-Bs
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 15:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cJ4PZ-0002lR-7w
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 15:19:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cJ4PY-0002lL-VE
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 15:19:53 -0500
References: <1478265017-5700-1-git-send-email-thuth@redhat.com>
	<87wpg5di5o.fsf@emacs.mitica> <20161117034511.GG18808@umbus.fritz.box>
	<b20c6b22-fc3a-b37a-6ea0-169be815864a@redhat.com>
	<401600f0-8a1c-22c7-b9f3-7424426ec699@redhat.com>
	<20161216170357.GD2642@work-vm>
	<5a7603d3-aa76-aa93-b6a0-80496284cecf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <93a4e714-f77a-ba16-70d8-e33dbd860e48@redhat.com>
Date: Mon, 19 Dec 2016 15:19:50 -0500
MIME-Version: 1.0
In-Reply-To: <5a7603d3-aa76-aa93-b6a0-80496284cecf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Is block_save_iterate() dead code?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>



On 12/19/2016 11:30 AM, Thomas Huth wrote:
> On 16.12.2016 18:03, Dr. David Alan Gilbert wrote:
>> * Thomas Huth (thuth@redhat.com) wrote:
>>> On 18.11.2016 09:13, Thomas Huth wrote:
>>>> On 17.11.2016 04:45, David Gibson wrote:
>>>>> On Mon, Nov 14, 2016 at 07:34:59PM +0100, Juan Quintela wrote:
>>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>>> qemu_savevm_state_iterate() expects the iterators to return 1
>>>>>>> when they are done, and 0 if there is still something left to do.
>>>>>>> However, ram_save_iterate() does not obey this rule and returns
>>>>>>> the number of saved pages instead. This causes a fatal hang with
>>>>>>> ppc64 guests when you run QEMU like this (also works with TCG):
>>>>>>>
>>>>>>>  qemu-img create -f qcow2  /tmp/test.qcow2 1M
>>>>>>>  qemu-system-ppc64 -nographic -nodefaults -m 256 \
>>>>>>>                    -hda /tmp/test.qcow2 -serial mon:stdio
>>>>>>>
>>>>>>> ... then switch to the monitor by pressing CTRL-a c and try to
>>>>>>> save a snapshot with "savevm test1" for example.
>>>>>>>
>>>>>>> After the first iteration, ram_save_iterate() always returns 0 here,
>>>>>>> so that qemu_savevm_state_iterate() hangs in an endless loop and you
>>>>>>> can only "kill -9" the QEMU process.
>>>>>>> Fix it by using proper return values in ram_save_iterate().
>>>>>>>
>>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>>
>>>>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>>>>>
>>>>>> Applied.
>>>>>>
>>>>>> I don't know how we broked this so much.
>>>>>
>>>>> Note that block save iterate has the same bug...
>>>>
>>>> I think you're right. Care to send a patch?
>>>
>>> Looking at this issue again ... could it be that block_save_iterate() is
>>> currently just dead code?
>>> As far as I can see, the ->save_live_iterate() handlers are only called
>>> from qemu_savevm_state_iterate(), right? And qemu_savevm_state_iterate()
>>> only calls the handlers if se->ops->is_active(se->opaque) returns true.
>>> But block_is_active() seems to only return 0 during savevm, most likely
>>> because qemu_savevm_state() explicitly sets the "blk" and "shared"
>>> MigrationParams to zero.
>>> So to me, it looks like we could also just remove block_save_iterate()
>>> completely ... or did I miss something here?
>>
>> Doesn't it get called by migrate -b ?
> 
> Ah, right, yes, I somehow missed that ... I probably shouldn't do such
> experiments at the end of Friday afternoon ;-)
> 
> OK, so it seems that
> - block_save_iterate() is not called during savevm at all
>   (and thus the bad return code does not matter here)
> - migrate -b runs block_save_iterate() but the return code is ignored in
>   migration_thread()
> 
> So we do not have a real problem here, but I think we should still clean
> up the return code of block_save_iterate() to be on the safe side for
> the future...
> 
>  Thomas
> 
> 

If it confused you, it'll confuse someone else. Worth fixing for
consistency's sake alone.

--js
