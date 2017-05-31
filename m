Received: from eggs.gnu.org ([2001:4830:134:3::10]:41807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dFyRf-0001yf-1T
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dFyRc-0002Kg-Eq
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:53:31 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dFyRc-0002KP-6P
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:53:28 -0400
Received: by mail-wr0-x233.google.com with SMTP id g76so4284375wrd.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 00:53:28 -0700 (PDT)
References: <20170517145259.28979-1-alex.bennee@linaro.org>
	<20170517145259.28979-7-alex.bennee@linaro.org>
	<CAJhHMCB0j9=6XBMa0GVaOt+Acf4m5Ow2DhvvvcekKJXhfM+qSg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAJhHMCB0j9=6XBMa0GVaOt+Acf4m5Ow2DhvvvcekKJXhfM+qSg@mail.gmail.com>
Date: Wed, 31 May 2017 08:53:42 +0100
Message-ID: <8737bltqbd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] new
 script/analyse-tlb-flushes-simpletrace.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani+qemu@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Emilio G. Cota" <cota@braap.org>, qemu-devel <qemu-devel@nongnu.org>


Pranith Kumar <bobby.prani+qemu@gmail.com> writes:

> Hi Alex,
>
> Please find some comments and questions below:
>
> On Wed, May 17, 2017 at 10:52 AM, Alex Bennée <alex.bennee@linaro.org> wrote:
>> This is a simple helper script to extract TLB flush stats from the a
>> simpletrace file and plot the results.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> ---
>> v2
>>   - re-factored for new trace events
>>   - added time and latency graphs
>> ---
>>  scripts/analyse-tlb-flushes-simpletrace.py | 144 +++++++++++++++++++++++++++++
>>  1 file changed, 144 insertions(+)
>>  create mode 100755 scripts/analyse-tlb-flushes-simpletrace.py
>>
>> diff --git a/scripts/analyse-tlb-flushes-simpletrace.py b/scripts/analyse-tlb-flushes-simpletrace.py
>> new file mode 100755
>> index 0000000000..03fab8c86b
>> --- /dev/null
>> +++ b/scripts/analyse-tlb-flushes-simpletrace.py
>
> <snip>
>
>> +
>> +def get_args():
>> +    "Grab options"
>> +    parser = argparse.ArgumentParser()
>> +    parser.add_argument("--output", "-o", type=str, help="Render plot to file")
>> +    parser.add_argument("--vcpus", type=int, help="Number of vCPUS")
>
> It is not really clear what this argument is for. I guess you are
> saying how many cpus the guest from which trace file was generated
> had? What happens if we pass in less number of vcpus than used for
> generation?

Yeah it's a bit of a hack. I need to know how many vcpus there are so
when we save an "all vcpu" event we can set the event in:

    def __save_queue(self, vcpu, record):
        self.flush_total += 1
        # FIXME: don't seem to see -1
        if vcpu > 0x7fffffff:
            self.flush_all += 1
            for i in range(0, self.nvcpus):
                self.vcpu_last[i].append(record)
        else:
            self.vcpu_last[vcpu].append(record)


>
>> +    parser.add_argument("--graph", choices=['time', 'latency'], default='time')
>
> What does latency here indicate? I tried this argument on a sample
> trace file I generated, and it had three empty boxes.

Time just tracks the culmlative total of flush events over time where as
latency gives a distribution of time from queuing the flush event to it
being processed.

>
>> +    parser.add_argument("events", type=str, help='trace file read from')
>> +    parser.add_argument("tracefile", type=str, help='trace file read from')
>
> The help text for 'events' file here should be something like 'the
> trace events file'.

Good catch, will fix.

>
> Thanks,


--
Alex Bennée
