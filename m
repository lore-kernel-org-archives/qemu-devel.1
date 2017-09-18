Received: from eggs.gnu.org ([2001:4830:134:3::10]:42644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1du2Dw-0006mA-Cf
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 16:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1du2Dt-0003u8-8r
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 16:00:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1du2Dt-0003tV-2E
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 16:00:53 -0400
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-24-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <651594b8-0d18-fd61-f0e9-287ad098306d@redhat.com>
Date: Mon, 18 Sep 2017 22:00:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-24-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 23/27] s390x/tcg: implement STOP and
 RESET interrupts for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>


>  static void cpu_inject_io(S390CPU *cpu, uint16_t subchannel_id,
> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
> index ce8fda9d01..521dcc75f3 100644
> --- a/target/s390x/sigp.c
> +++ b/target/s390x/sigp.c
> @@ -498,6 +498,7 @@ void do_stop_interrupt(CPUS390XState *env)
>          s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
>      }
>      env->sigp_order = 0;
> +    env->pending_int &= ~INTERRUPT_STOP;

The *awesome* kvm-unit-tests (yes, the single sigp_stop() we do when
shutting down) just found a missing cpu_loop_exit()

diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index ce8fda9d01..9aadc3ffdd 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -498,6 +498,11 @@ void do_stop_interrupt(CPUS390XState *env)
         s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
     }
     env->sigp_order = 0;
+    env->pending_int &= ~INTERRUPT_STOP;
+#ifdef CONFIG_TCG
+    /* the CPU has been stopped, we must immediately go out of the loop */
+    cpu_loop_exit(CPU(s390_env_get_cpu(env)));
+#endif
 }


>  }
>  
>  void s390_init_sigp(void)
> 


-- 

Thanks,

David
