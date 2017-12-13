Received: from eggs.gnu.org ([2001:4830:134:3::10]:50443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePEcg-0007TW-8g
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePEcd-0006U0-4s
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:31:26 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:45826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ePEcc-0006Se-V9
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:31:23 -0500
Received: by mail-wm0-f49.google.com with SMTP id 9so7650093wme.4
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 13:31:22 -0800 (PST)
References: <20171213180807.7066-1-dgilbert@redhat.com>
	<20171213180807.7066-5-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dd448e34-6a23-17d2-3cce-580c08c6de9f@redhat.com>
Date: Wed, 13 Dec 2017 22:31:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171213180807.7066-5-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/6] vhost: add regions to temporary list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com, groug@kaod.org, mst@redhat.com

On 13/12/2017 19:08, Dr. David Alan Gilbert (git) wrote:
> +    if (dev->tmp_mem->nregions) {
> +        /* Since we already have at least one region, lets see if
> +         * this extends it; since we're scanning in order, we only
> +         * have to look at the last one, and the FlatView that calls
> +         * us shouldn't have overlaps.
> +         */
> +        struct vhost_memory_region *prev_vmr = dev->tmp_mem->regions +
> +                                               (dev->tmp_mem->nregions - 1);
> +        uint64_t prev_gpa_start = prev_vmr->guest_phys_addr;
> +        uint64_t prev_gpa_end   = range_get_last(prev_gpa_start,
> +                                                 prev_vmr->memory_size);
> +        uint64_t prev_host_start = prev_vmr->userspace_addr;
> +        uint64_t prev_host_end   = range_get_last(prev_host_start,
> +                                                  prev_vmr->memory_size);
> +
> +        if (prev_gpa_end + 1 == mrs_gpa &&
> +            prev_host_end + 1 == mrs_host &&
> +            (!dev->vhost_ops->vhost_backend_can_merge ||
> +                dev->vhost_ops->vhost_backend_can_merge(dev,
> +                    mrs_host, mrs_size,
> +                    prev_host_start, prev_vmr->memory_size))) {
> +            /* The two regions abut */
> +            need_add = false;
> +            mrs_size = mrs_size + prev_vmr->memory_size;
> +            prev_vmr->memory_size = mrs_size;
> +            trace_vhost_region_add_tmp_abut(section->mr->name, mrs_size);
> +        }
> +    }

Interesting, in which cases does this actually trigger?

Paolo
