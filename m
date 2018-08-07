Received: from eggs.gnu.org ([2001:4830:134:3::10]:51517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn3IW-0004Qu-5j
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn3IR-0001kj-Cl
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:49:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fn3IR-0001kW-6g
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:49:15 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA81Xr6_eUV5247JtZRnN9Ms7fau1iwhHkmW-gnwH9y8JA@mail.gmail.com>
	(Peter Maydell's message of "Tue, 7 Aug 2018 15:39:29 +0100")
References: <20180807130355.29780-1-peter.maydell@linaro.org>
	<87muty2u57.fsf@trasno.org>
	<CAFEAcA_m+81aDQR=n=8gXhcifYp0L6n9KZA5COQsRejeqZe2FQ@mail.gmail.com>
	<87in4m2qni.fsf@trasno.org>
	<CAFEAcA81Xr6_eUV5247JtZRnN9Ms7fau1iwhHkmW-gnwH9y8JA@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Tue, 07 Aug 2018 16:49:10 +0200
Message-ID: <87wot21bbt.fsf@trasno.org>
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
> On 7 August 2018 at 15:32, Juan Quintela <quintela@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 7 August 2018 at 14:17, Juan Quintela <quintela@redhat.com> wrote:
>>> Also, what prompted me to write this patch was that for 3.0
>>> I had to fix several bugs where subsections had been written
>>> with no needed function and the migration code was (a)
>>> silently ignoring the subsection and (b) silently ignoring
>>> any subsection following. If you want to make it a bug to
>>
>> b) is clearly a bug.
>>
>> a) ... I am not sure that this should be correct.
>
> I can see these plausible API choices:
>  (1) .needed for a subsection VMSD has the same behaviour as
>      .needed for a top-level VMSD: if not present, means "always"
>  (2) .needed is mandatory for a subsection VMSD, and failure
>      to provide it is a bug which we diagnose as early as
>      possible

I vote for (2)


> If I understand you correctly you're suggesting
>  (3) .needed is not mandatory and if not present means
>      "never transfer the subsection"
> which I think would be confusing.

No.  I am suggestion that not having "needed" is a bug.

> I could live with (2) but I would end up writing a lot
> of .needed functions like
>
> static bool needed_always(void *opaque)
> {
>     return true;
> }

vmstate_needed_always() can be exported.
>
> which seems a bit unnecessary. (I have another patchset
> in the works which will have one of these, assuming this
> patch doesn't go into master first.)

But what I wonder is _why_ we want subsections that are always there.
We have:

- normal sections
  int32_t foo
  int64_t bad;

- subsections (always optional)
  if needed(whatever)
      int16_t foo2
      int32_t bar2

So needed_always means that it is never optional, it is always sent.
Here we have two cases:

- migration from old qemu (subsction don't exist) to new qemu works
  then the subsection clearly is mandatory

- migration from old qemu to new qemu don't work, because there are
  missing bits:
    then there is not problem adding the fields to the toplevel section
    and increasing the version number, because we can't migrate from
  older versions.

I can't see how to can make both claims true at the same time.

Later, Juan.
