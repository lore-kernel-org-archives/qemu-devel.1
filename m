Received: from eggs.gnu.org ([209.51.188.92]:45037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr24v-0004hh-Gx
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr20N-0002kY-4e
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:47:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gr20F-0002gj-Sj
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:47:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so3887397wrx.9
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 06:47:10 -0800 (PST)
References: <ae28cefe-84fb-6c4e-0452-55b717726b2b@redhat.com>
	<CABLmASEAbmGRohbvZag0jWYqvxys=dUiKeTJyN2=CYE+X1JAXQ@mail.gmail.com>
	<CAFEAcA9sLhi__xgQz9xXyyjxyuRN1ayAUykFgTb_rHCfEtVipg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <221f03c2-10ca-dc90-83f6-3781c356c8e0@redhat.com>
Date: Tue, 5 Feb 2019 15:47:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9sLhi__xgQz9xXyyjxyuRN1ayAUykFgTb_rHCfEtVipg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, Howard Spoelstra <hsp.cat7@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, qemu-ppc <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>

Hi Peter,

On 2/5/19 2:45 PM, Peter Maydell wrote:
> On Tue, 5 Feb 2019 at 08:37, Howard Spoelstra <hsp.cat7@gmail.com> wrote:
>> On Fri, Feb 1, 2019 at 11:54 PM Cleber Rosa <crosa@redhat.com> wrote:
>>>
>>> While working on the "boot_linux_console.py" tests, after a given
>>> rebase, I noticed that the ppc64 specific test began timing out.  The
>>> original timeout set to the test was 60 seconds, and it "always" had
>>> room to spare when running either on my system, or on Travis CI.
>>>
>> Hi,
>>
>> As reported on IRC on 31-01, performance loss also occurs with qemu-system-ppc:
>> "I noticed a substantial performance loss (~35% in processor benchmark) in qemu-system-ppc running Mac OS 9.2. Bisecting shows that https://github.com/qemu/qemu/commit/f7b78602fdc6c6e4befc90159da8e93900b4bcb1 introduces the issue. Reverting brings performance back."
> 
> Yeah; Mark Cave-Ayland did a bit more digging into this last night,
> and I have a patch that fixes it. I'll send that in a moment when
> I've confirmed that I've caught all the places we need to fold
> the cluster index into the hash cflags value.

I was going to send this patch and was looking for to fill the
"Reported-by" tag to finalize the commit description before sending:

-- >8 --
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index aa7b81aaf0..8dc2aab60e 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -418,7 +418,8 @@ static inline uint32_t tb_cflags(const
TranslationBlock *tb)
 static inline uint32_t curr_cflags(void)
 {
     return (parallel_cpus ? CF_PARALLEL : 0)
-         | (use_icount ? CF_USE_ICOUNT : 0);
+         | (use_icount ? CF_USE_ICOUNT : 0)
+         | CF_CLUSTER_MASK;
 }
---

I believe your patch description is way more correct/detailled than mine :P

Regards,

Phil.
