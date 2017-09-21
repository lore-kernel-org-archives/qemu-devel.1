Received: from eggs.gnu.org ([2001:4830:134:3::10]:42718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duwld-0007uu-GH
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duwla-0002MR-A7
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:23:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duwla-0002Lv-4l
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:23:26 -0400
Date: Thu, 21 Sep 2017 10:23:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170921102318.1d7784f1.cohuck@redhat.com>
In-Reply-To: <20170920153016.3858-1-david@redhat.com>
References: <20170920153016.3858-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Implement basic MSA functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On Wed, 20 Sep 2017 17:30:13 +0200
David Hildenbrand <david@redhat.com> wrote:

> Some leftover from "target/s390x: tcg improvments + MSA functions".
> 
> Implement all basic MSA (cpacf/crypto) instructions <= z13. Only provide
> the query subfunction (to query available subfunctions), no actual
> de/encryption yet. Good enough to unlock the STFL bits.
> 
> I have written kvm-unit-tests for MSA functions and for SPM/IPM. Will
> send them out soon. I use the following cpu model to test with an upstream
> kernel compiled for z10:
> 
> ... -cpu qemu,mvcos=on,stfle=on,ldisp=on,ldisphp=on,\
>               eimm=on,stckf=on,csst=on,csst2=on,ginste=on,\
>               exrl=on,msa-base=on,msa3-base=on,msa4-base=on,msa5-base=on ...
> 
> Available on: https://github.com/davidhildenbrand/qemu.git s390x-msa

I used the following cpu model:

-cpu qemu,eimm=on,ldisp=on,stckf=on,msa-base=on,msa3-base=on,msa4-base=on,msa5-base=on

and got

qemu-system-s390x: warning: 'msa5-base' requires 'kimd-sha-512'.
qemu-system-s390x: warning: 'msa5-base' requires 'klmd-sha-512'.

(It works anyway.)

However,

-cpu qemu,eimm=on,ldisp=on,stckf=on,msa-base=on,msa3-base=on,msa4-base=on,msa5-base=on,kimd-sha-512=on

gives

qemu-system-s390x: can't apply global qemu-s390-cpu.kimd-sha-512=on: Feature 'kimd-sha-512' is not available for CPU model 'z900', it was introduced with later models.

which is a bit confusing.

So I'm wondering whether providing msa5-base without the providing the
algorithms above is sane - or whether it is just enough to satisfy some
kernels.

[Double-checking the various dependencies looks impossible without
access to IBM doc, anyway - I just hope you got it right back then :)]
