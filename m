Received: from eggs.gnu.org ([2001:4830:134:3::10]:57203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn3YV-0006cY-QJ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn3YR-0002YF-Qk
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:05:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37956 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fn3YR-0002Y3-K4
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:05:47 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA_y1qKsC8kSDee+FEpqZstz9UHTeyP6ABuGfXf_aDMRHw@mail.gmail.com>
	(Peter Maydell's message of "Tue, 7 Aug 2018 16:00:06 +0100")
References: <20180807130355.29780-1-peter.maydell@linaro.org>
	<87muty2u57.fsf@trasno.org>
	<CAFEAcA_m+81aDQR=n=8gXhcifYp0L6n9KZA5COQsRejeqZe2FQ@mail.gmail.com>
	<87in4m2qni.fsf@trasno.org>
	<CAFEAcA81Xr6_eUV5247JtZRnN9Ms7fau1iwhHkmW-gnwH9y8JA@mail.gmail.com>
	<87wot21bbt.fsf@trasno.org>
	<CAFEAcA_y1qKsC8kSDee+FEpqZstz9UHTeyP6ABuGfXf_aDMRHw@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Tue, 07 Aug 2018 17:05:41 +0200
Message-ID: <87o9ee1aka.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: Correctly handle subsections
 with no 'needed' function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 7 August 2018 at 15:49, Juan Quintela <quintela@redhat.com> wrote:
>> But what I wonder is _why_ we want subsections that are always there.
>> We have:
>>
>> - normal sections
>>   int32_t foo
>>   int64_t bad;
>>
>> - subsections (always optional)
>>   if needed(whatever)
>>       int16_t foo2
>>       int32_t bar2
>>
>> So needed_always means that it is never optional, it is always sent.
>> Here we have two cases:
>>
>> - migration from old qemu (subsction don't exist) to new qemu works
>>   then the subsection clearly is mandatory
>>
>> - migration from old qemu to new qemu don't work, because there are
>>   missing bits:
>>     then there is not problem adding the fields to the toplevel section
>>     and increasing the version number, because we can't migrate from
>>   older versions.
>>
>> I can't see how to can make both claims true at the same time.
>
> The usual situation is:
>  * we write a device, but it's missing some bit of functionality
>    and so is missing some internal state
>  * later, we add that functionality, and the internal state, and
>    now we want to add that state to the migration struct
>  * we would like to not break migration from the old QEMU to
>    the new one in the (fairly common) case where actually the
>    guest wasn't using that bit of the device and doesn't care
>    about its state
>
> We could do that by putting the fields into the existing
> vmstate struct, and marking them as only being present in
> newer versions. But using migration version numbers is
> brittle, especially if sometimes a feature might be backported
> to an earlier version, or if downstreams make changes.
> So it's better to use a needed-always subsection, which will give
> the desired behaviour:
>  * new QEMU -> new QEMU: state is always migrated
>  * old QEMU -> new QEMU: migration doesn't fail, and guest
>    will work assuming it didn't care about this corner of the
>    device's functionality (the device will end up with state
>    as it was at reset, or possibly special-cased via
>    pre_load/post_load hooks for the "section not present" case)

we break by definiton new QEMU -M <old machine type> into old QEMU.

That is the whole point why I don't like that.  But I understand your
point.  We have to decide if we care about making:

QEMU-x.y -M board-x.y
QEMU-z.y -M board-x.y

working more or less.

Later, Juan.
