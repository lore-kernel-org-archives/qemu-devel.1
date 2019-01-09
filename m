Received: from eggs.gnu.org ([209.51.188.92]:35103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1ghHi6-0000LF-Ne
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1ghHi4-0003t6-Af
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:32:10 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:40153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1ghHi4-0003rO-0s
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:32:08 -0500
Received: by mail-qt1-x844.google.com with SMTP id k12so9190856qtf.7
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 09:32:07 -0800 (PST)
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <bcb40bb6-44e6-441c-8d31-d3e91a3f25e2@gmail.com>
Date: Wed, 9 Jan 2019 15:32:03 -0200
MIME-Version: 1.0
In-Reply-To: <200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, kwolf@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com



On 1/9/19 3:05 PM, Max Reitz wrote:
> On 09.01.19 17:57, Daniel Henrique Barboza wrote:
>>
>> On 1/9/19 12:10 PM, Max Reitz wrote:
>>> On 06.09.18 13:11, Daniel Henrique Barboza wrote:
>>>> changes in v2:
>>>> - removed the "RFC" marker;
>>>> - added a new patch (patch 2) that removes
>>>> bdrv_snapshot_delete_by_id_or_name from the code;
>>>> - made changes in patch 1 as suggested by Murilo;
>>>> - previous patch set link:
>>>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.html
>>>>
>>>>
>>>> It is not uncommon to see bugs being opened by testers that attempt to
>>>> create VM snapshots using HMP. It turns out that "0" and "1" are quite
>>>> common snapshot names and they trigger a lot of bugs. I gave an example
>>>> in the commit message of patch 1, but to sum up here: QEMU treats the
>>>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. It
>>>> is documented as such, but this can lead to strange situations.
>>>>
>>>> Given that it is strange for an API to consider a parameter to be 2
>>>> fields
>>>> at the same time, and inadvently treating them as one or the other, and
>>>> that removing the ID field is too drastic, my idea here is to keep the
>>>> ID field for internal control, but do not let the user set it.
>>>>
>>>> I guess there's room for discussion about considering this change an API
>>>> change or not. It doesn't affect users of HMP and it doesn't affect
>>>> Libvirt,
>>>> but simplifying the meaning of the parameters of savevm/loadvm/delvm.
>>> (Yes, very late reply, I'm sorry...)
>>>
>>> I do think it affects users of HMP, because right now you can delete
>>> snapshots with their ID, and after this series you cannot.
>> That's true. My idea here was simple: the user can't reliably exclude
>> via snapshot ID today
>> because we're hiding the ID field in info snapshots:
>>
>>
>>      (qemu) savevm 0
>>      (qemu) info snapshots
>>      List of snapshots present on all disks:
>>      ID        TAG                 VM SIZE                DATE VM CLOCK
>>      --        0                      741M 2018-07-31 13:39:56 00:41:25.313
>>
>>
>> Thus, what will end up happening is that the user will be forced to use the
>> TAG of the snapshot since this is the only available information.
> But you can get it through e.g. qemu-img info.
>
> Snapshot list:
> ID        TAG                 VM SIZE                DATE       VM CLOCK
> 1         0                      1.6M 2019-01-09 18:01:21   00:00:02.657
>
> So it's not impossible to get.

Hmpf .... should we obscure the ID in this case as well? I mean, why we
have the ID information here but not in "info snapshots"?


>>> I think we had a short discussion about just disallowing numeric
>>> snapshot names.  How bad would that be?
>>
>> This was my first idea when evaluating what to do in this case. I gave
>> it up because
>> I found it to be too extreme. People would start complaining "I was able
>> to do
>> savevm 0 and now I can't".
> True.  But it wouldn't be impossible to do, we'd need to deprecate
> numeric names, print a warning for two releases, and then we can make it
> an error.
>
> Hm...  If we had a proper deprecation warning in this series, I suppose
> it wouldn't be dangerous anymore.  Can we just print a warning whenever
> the user specified an ID?  (i.e. if some snapshot's ID matches the
> string given by the user and the snapshot's name does not)


I can live with that.



>
> Max
>
