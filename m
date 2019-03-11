Received: from eggs.gnu.org ([209.51.188.92]:51917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h3NZj-0005qv-3T
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h3NZc-0003PY-CY
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:14:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1h3NZZ-0003It-3Q
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:14:42 -0400
From: Bandan Das <bsd@redhat.com>
References: <20190307095441.31921-1-kraxel@redhat.com>
	<20190307095441.31921-4-kraxel@redhat.com>
	<CAFEAcA_HzSj7sQ+aKEwHmJXkJcG8yLmn5ZsZKM5xxYUrBxO2rQ@mail.gmail.com>
	<jpg36nxf8ta.fsf@linux.bootlegged.copy>
	<jpg8sxpypx2.fsf_-_@linux.bootlegged.copy>
	<CAFEAcA_3=cQDHibDe++d+6UpkHhKMP8=s4iJYbqUVeJdDQv+fQ@mail.gmail.com>
Date: Mon, 11 Mar 2019 12:14:33 -0400
In-Reply-To: <CAFEAcA_3=cQDHibDe++d+6UpkHhKMP8=s4iJYbqUVeJdDQv+fQ@mail.gmail.com>
	(Peter Maydell's message of "Sat, 9 Mar 2019 14:13:18 +0000")
Message-ID: <jpg8sxle6c6.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: fix return status of delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 8 Mar 2019 at 22:14, Bandan Das <bsd@redhat.com> wrote:
>>
>>
>> Spotted by Coverity: CID 1399414
>>
>> mtp delete allows the a return status of delete succeeded,
>> partial_delete or readonly - when none of the objects could be
>> deleted.
>>
>> Some initiators recurse over the objects themselves. In that case,
>> only READ_ONLY can be returned.
>>
>> Signed-off-by: Bandan Das <bsd@redhat.com>
>> ---
>>  hw/usb/dev-mtp.c | 25 +++++++++----------------
>>  1 file changed, 9 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
>> index 06e376bcd2..e3401aad75 100644
>> --- a/hw/usb/dev-mtp.c
>> +++ b/hw/usb/dev-mtp.c
>> @@ -1137,9 +1137,9 @@ static MTPData *usb_mtp_get_object_prop_value(MTPState *s, MTPControl *c,
>>
>>  /* Return correct return code for a delete event */
>>  enum {
>> -    ALL_DELETE,
>> -    PARTIAL_DELETE,
>> +    ALL_DELETE = 1,
>>      READ_ONLY,
>> +    PARTIAL_DELETE,
>
> This is an enum, ie a set of incrementing values, but you're
> using them as bit positions you're ORing together. If they're
> really bit flags you should define them properly that way,
> so it's clear what you're doing.
>
Sure, no problem

> At the moment PARTIAL_DELETE is "ALL_DELETE | READ_ONLY", which
> doesn't seem like it makes much sense.
>

Sorry, can you please clarify what doesn't make sense ?

> thanks
> -- PMM
