Received: from eggs.gnu.org ([2001:4830:134:3::10]:60479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4Y6l-0003AF-MN
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 16:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4Y6g-00015Z-Nb
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 16:04:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45427)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4Y6g-00014E-GO
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 16:04:54 -0400
Date: Tue, 17 Oct 2017 16:04:51 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171017200451.GA1345@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016172609.23422-2-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 01/50] tcg: Merge opcode arguments into
 TCGOp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, Oct 16, 2017 at 10:25:20 -0700, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
> 
> Rather than have a separate buffer of 10*max_ops entries,
> give each opcode 10 entries.  The result is actually a bit
> smaller and should have slightly more cache locality.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Emilio G. Cota <cota@braap.org>

This gives a small yet measurable perf advantage when booting linux:

 Performance counter stats for 'taskset -c 0 aarch64-softmmu/qemu-system-aarch64 \
	-M virt,gic_version=3 -cpu cortex-a57 -nographic -m 4096 -netdev \
	user,id=unet,hostfwd=tcp::2222-:22 -device virtio-net-device,netdev=unet \
	-drive file=jessie-arm64-die-on-boot.qcow2,id=myblock,index=0,if=none \
	-device virtio-blk-device,drive=myblock -kernel \
	aarch64-current-linux-kernel-only.img \
	-append console=ttyAMA0 root=/dev/vda1 -smp 1' (10 runs):

Before:
       7182.556704      task-clock (msec)         #    0.999 CPUs utilized            ( +-  0.11% )
            21,710      context-switches          #    0.003 M/sec                    ( +-  0.12% )
                 1      cpu-migrations            #    0.000 K/sec                    ( +- 11.11% )
             7,929      page-faults               #    0.001 M/sec                    ( +-  1.75% )
    30,280,536,799      cycles                    #    4.216 GHz                      ( +-  0.11% )
   <not supported>      stalled-cycles-frontend  
   <not supported>      stalled-cycles-backend   
    54,481,515,301      instructions              #    1.80  insns per cycle          ( +-  0.09% )
     9,655,822,880      branches                  # 1344.343 M/sec                    ( +-  0.10% )
       170,594,899      branch-misses             #    1.77% of all branches          ( +-  0.10% )

       7.190274755 seconds time elapsed                                          ( +-  0.11% )


After:
       7086.254881      task-clock (msec)         #    0.999 CPUs utilized            ( +-  0.13% )
            21,598      context-switches          #    0.003 M/sec                    ( +-  0.07% )
                 1      cpu-migrations            #    0.000 K/sec                  
             8,099      page-faults               #    0.001 M/sec                    ( +-  0.97% )
    29,856,727,544      cycles                    #    4.213 GHz                      ( +-  0.12% )
   <not supported>      stalled-cycles-frontend  
   <not supported>      stalled-cycles-backend   
    53,585,205,542      instructions              #    1.79  insns per cycle          ( +-  0.10% )
     9,638,601,205      branches                  # 1360.183 M/sec                    ( +-  0.10% )
       169,785,181      branch-misses             #    1.76% of all branches          ( +-  0.08% )

       7.094560954 seconds time elapsed

That is, a 1.33% perf improvement.

		Emilio
