Received: from eggs.gnu.org ([2001:4830:134:3::10]:44408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdTgk-00087S-KZ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 22:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdTgg-0002Uv-NR
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 22:21:58 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1486636445-24109-6-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170210001035.GJ27610@umbus.fritz.box>
	<87k28yekze.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170214024331.GD2169@umbus.fritz.box>
	<87o9y5eale.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2094c8e6-2b99-9c09-7eb2-c013dd07ec1e@twiddle.net>
Date: Tue, 14 Feb 2017 14:21:36 +1100
MIME-Version: 1.0
In-Reply-To: <87o9y5eale.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] target-ppc: support for 32-bit carry
 and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 02/14/2017 02:05 PM, Nikunj A Dadhania wrote:
> Yes, you are right. I had a discussion with Paul Mackerras yesterday, he
> explained to me in detail about the bits. I am working on the revised
> implementation. Will detail it in the commit message.

As you're working on this, consider changing the definition of cpu_ov such that 
the MSB is OV and bit 31 is OV32.

E.g.


  static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
                                             TCGv arg1, TCGv arg2, int sub)
  {
      TCGv t0 = tcg_temp_new();

      tcg_gen_xor_tl(cpu_ov, arg0, arg2);
      tcg_gen_xor_tl(t0, arg1, arg2);
      if (sub) {
          tcg_gen_and_tl(cpu_ov, cpu_ov, t0);
      } else {
          tcg_gen_andc_tl(cpu_ov, cpu_ov, t0);
      }
      tcg_temp_free(t0);
      if (NARROW_MODE(ctx)) {
          tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
      }
-    tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);
      tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
  }


is all that is required for arithmetic to compute OV and OV32 into those two bits.

Obviously more is required for multiplication and division, and you'd also have 
to change cpu_so to examine the MSB as well.


r~
