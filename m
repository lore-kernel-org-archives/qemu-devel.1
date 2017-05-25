Received: from eggs.gnu.org ([2001:4830:134:3::10]:40546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDv48-0006M7-KL
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDv45-0004YI-H2
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:52:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dDv45-0004Wb-Ax
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:52:41 -0400
References: <1495229390-18909-1-git-send-email-felipe@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <869fcc91-40ff-97fa-2a82-ca34695ac864@redhat.com>
Date: Thu, 25 May 2017 17:52:36 +0200
MIME-Version: 1.0
In-Reply-To: <1495229390-18909-1-git-send-email-felipe@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cpus: reset throttle_thread_scheduled
 after sleep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Malcolm Crossley <malcolm@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 19/05/2017 23:29, Felipe Franciosi wrote:
> Currently, the throttle_thread_scheduled flag is reset back to 0 before
> sleeping (as part of the throttling logic). Given that throttle_timer
> (well, any timer) may tick with a slight delay, it so happens that under
> heavy throttling (ie. close or on CPU_THROTTLE_PCT_MAX) the tick may
> schedule a further cpu_throttle_thread() work item after the flag reset,
> but before the previous sleep completed. This results on the vCPU thread
> sleeping continuously for potentially several seconds in a row.
> 
> The chances of that happening can be drastically minimised by resetting
> the flag after the sleep.

True, on the other hand this may also increase the chance of not
sleeping at all.

How overcommitted was the host system?

Paolo

> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> Signed-off-by: Malcolm Crossley <malcolm@nutanix.com>
