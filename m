Received: from eggs.gnu.org ([209.51.188.92]:47240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1ghISX-0001X2-AJ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1ghISU-0001Hv-56
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:20:08 -0500
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:46755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1ghISS-0001G2-6L
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:20:04 -0500
Received: by mail-qt1-x841.google.com with SMTP id y20so9343637qtm.13
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 10:20:03 -0800 (PST)
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<20190109142140.GC4867@localhost.localdomain>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <61ce2eef-0bb4-5928-b062-80b493cd441b@gmail.com>
Date: Wed, 9 Jan 2019 16:19:58 -0200
MIME-Version: 1.0
In-Reply-To: <20190109142140.GC4867@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com



On 1/9/19 12:21 PM, Kevin Wolf wrote:
> Am 09.01.2019 um 15:10 hat Max Reitz geschrieben:
>> On 06.09.18 13:11, Daniel Henrique Barboza wrote:
>>> changes in v2:
>>> - removed the "RFC" marker;
>>> - added a new patch (patch 2) that removes
>>> bdrv_snapshot_delete_by_id_or_name from the code;
>>> - made changes in patch 1 as suggested by Murilo;
>>> - previous patch set link:
>>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.html
>>>
>>>
>>> It is not uncommon to see bugs being opened by testers that attempt to
>>> create VM snapshots using HMP. It turns out that "0" and "1" are quite
>>> common snapshot names and they trigger a lot of bugs. I gave an example
>>> in the commit message of patch 1, but to sum up here: QEMU treats the
>>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. It
>>> is documented as such, but this can lead to strange situations.
>>>
>>> Given that it is strange for an API to consider a parameter to be 2 fields
>>> at the same time, and inadvently treating them as one or the other, and
>>> that removing the ID field is too drastic, my idea here is to keep the
>>> ID field for internal control, but do not let the user set it.
>>>
>>> I guess there's room for discussion about considering this change an API
>>> change or not. It doesn't affect users of HMP and it doesn't affect Libvirt,
>>> but simplifying the meaning of the parameters of savevm/loadvm/delvm.
>> (Yes, very late reply, I'm sorry...)
>>
>> I do think it affects users of HMP, because right now you can delete
>> snapshots with their ID, and after this series you cannot.
> Can there be snapshots that can't be identified by a snapshot name, but
> only by their ID?

Hmmm I would need to read my notes back when I was working on this series.
In a quick look at the code and playing around with HMP, what I can tell 
is that:

- there is no way for a snapshot to have an empty TAG - an auto-generated
name is generated and used as TAG.

-  if you create a snapshot using an existing TAG, the older snapshot is 
overwritten
without warning (would be nice to fix it to at least provide a warning 
message - I can
do it in this series if a respin is needed)


I do not have the expertise of the whole block layer to see further 
implications of
the changes made in this series, but as far as HMP goes, I don't think 
there's too much
to it other than what I've said in the cover letter. The goal here is to 
remove the
ambiguity of save/load/del vm commands that would interpret the argument
either as tag or ID, leading to situations in which snapshots ended up 
getting
overwritten because the tag matched an existing ID.


I am not against providing a warning message if the user tries to create 
a snapshot
using a numerical tag. In the end, although I said otherwise in the 
cover letter, changing
the meaning of an input is still an API change, and I'd rather error on 
the cautious side
and warn the callers about it. Even if this has no/little impact (please 
feel free to prove
me wrong) on them.



Daniel






>
>> I think we had a short discussion about just disallowing numeric
>> snapshot names.  How bad would that be?
> It would be incompatible with existing images and result in a more
> complex snapshot identifier resolution. Why would it be any better?
>
> Kevin
