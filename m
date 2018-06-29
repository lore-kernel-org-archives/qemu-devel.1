Received: from eggs.gnu.org ([2001:4830:134:3::10]:42939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYx8f-0005ng-LK
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYx8b-0000OX-Fe
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:24:53 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:40354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYx8b-0000Li-9v
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:24:49 -0400
Received: by mail-pf0-x22a.google.com with SMTP id z24-v6so4516692pfe.7
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 10:24:49 -0700 (PDT)
References: <20180629170520.13671-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <144b8041-46a0-4fbd-ee39-30ead9a723b1@linaro.org>
Date: Fri, 29 Jun 2018 10:24:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180629170520.13671-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tcg: fix locking problem with
 tcg_s390_tod_updated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>

On 06/29/2018 10:05 AM, David Hildenbrand wrote:
> tcg_s390_tod_updated() is always called with the iothread being locked
> (e.g. from S390TODClass->set() e.g. via HELPER(sck) or on incomming
> migration). The helper we call takes the lock itself - bad.
> 
> Let's change that by factoring out updating the ckc timer. This now looks
> much nicer than having to call a helper from another function.
> 
> While touch it we also make sure that env->ckc is updated even if the new
> value is -1ULL, for now it would not have been modified in that case.
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> This survives my tests and the iotests Christian mentioned.
> 
>  target/s390x/misc_helper.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
