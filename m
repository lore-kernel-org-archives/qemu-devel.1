Received: from eggs.gnu.org ([209.51.188.92]:53341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr2OG-000105-Cg
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr2O6-0002ty-Q4
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:11:54 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:39471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gr2O4-0002nS-KV
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:11:50 -0500
Received: by mail-wm1-f50.google.com with SMTP id y8so4040691wmi.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 07:11:43 -0800 (PST)
References: <ae28cefe-84fb-6c4e-0452-55b717726b2b@redhat.com>
	<CABLmASEAbmGRohbvZag0jWYqvxys=dUiKeTJyN2=CYE+X1JAXQ@mail.gmail.com>
	<CAFEAcA9sLhi__xgQz9xXyyjxyuRN1ayAUykFgTb_rHCfEtVipg@mail.gmail.com>
	<221f03c2-10ca-dc90-83f6-3781c356c8e0@redhat.com>
	<CAFEAcA8udaag9C6-_E0FN5skVjps1fTUGfa0w+j0yauvg3wUXw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e657a5ba-71da-8b49-d3e5-35e732991816@redhat.com>
Date: Tue, 5 Feb 2019 16:11:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8udaag9C6-_E0FN5skVjps1fTUGfa0w+j0yauvg3wUXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] 2x-3x tcg performance regression on
 ppc64 (maybe others)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, qemu-ppc <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>

On 2/5/19 4:08 PM, Peter Maydell wrote:
> On Tue, 5 Feb 2019 at 14:47, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> I was going to send this patch and was looking for to fill the
>> "Reported-by" tag to finalize the commit description before sending:
>>
>> -- >8 --
>> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
>> index aa7b81aaf0..8dc2aab60e 100644
>> --- a/include/exec/exec-all.h
>> +++ b/include/exec/exec-all.h
>> @@ -418,7 +418,8 @@ static inline uint32_t tb_cflags(const
>> TranslationBlock *tb)
>>  static inline uint32_t curr_cflags(void)
>>  {
>>      return (parallel_cpus ? CF_PARALLEL : 0)
>> -         | (use_icount ? CF_USE_ICOUNT : 0);
>> +         | (use_icount ? CF_USE_ICOUNT : 0)
>> +         | CF_CLUSTER_MASK;
>>  }
> 
> That's not right, because it puts all-1s in the cluster field.
> That will happen to hit for TBs generated for CPUs in the
> "not in a cluster" default UNASSIGNED_CLUSTER_INDEX, but it's
> wrong for CPUs that are in a specifically assigned cluster
> and will result in those failing to hit cached TBs when they should.

Oh OK now I understand.

Thanks for the explanation!

Phil.

> 
> thanks
> -- PMM
> 
