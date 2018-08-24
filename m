Received: from eggs.gnu.org ([2001:4830:134:3::10]:46830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftDmO-0005kA-LT
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftDmN-0004p5-U8
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:13:40 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:36706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftDmN-0004oj-LV
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:13:39 -0400
Received: by mail-oi0-x235.google.com with SMTP id r69-v6so15286621oie.3
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 08:13:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180820104045.133968-5-mst@redhat.com>
References: <20180820104045.133968-1-mst@redhat.com>
	<20180820104045.133968-5-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 16:13:18 +0100
Message-ID: <CAFEAcA9eOFMuvkN2gBetU4SSpV0Jp2hSVsjMG53_Cp8TrkObFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 4/7] hostmem-file: add the 'pmem' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 20 August 2018 at 21:24, Michael S. Tsirkin <mst@redhat.com> wrote:
> From: Junyan He <junyan.he@intel.com>
>
> When QEMU emulates vNVDIMM labels and migrates vNVDIMM devices, it
> needs to know whether the backend storage is a real persistent memory,
> in order to decide whether special operations should be performed to
> ensure the data persistence.
>
> This boolean option 'pmem' allows users to specify whether the backend
> storage of memory-backend-file is a real persistent memory. If
> 'pmem=on', QEMU will set the flag RAM_PMEM in the RAM block of the
> corresponding memory region. If 'pmem' is set while lack of libpmem
> support, a error is generated.

Hi; Coverity reports (CID 1395184) that there is a resource leak
in an error-exit path in this function:

> +static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
> +{
> +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
> +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
> +
> +    if (host_memory_backend_mr_inited(backend)) {
> +        error_setg(errp, "cannot change property 'pmem' of %s '%s'",
> +                   object_get_typename(o),
> +                   object_get_canonical_path_component(o));
> +        return;
> +    }
> +
> +#ifndef CONFIG_LIBPMEM
> +    if (value) {
> +        Error *local_err = NULL;
> +        error_setg(&local_err,
> +                   "Lack of libpmem support while setting the 'pmem=on'"
> +                   " of %s '%s'. We can't ensure data persistence.",
> +                   object_get_typename(o),
> +                   object_get_canonical_path_component(o));

object_get_canonical_path_component() returns a string which
must be freed using g_free().

> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +#endif
> +
> +    fb->is_pmem = value;
> +}

thanks
-- PMM
