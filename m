Received: from eggs.gnu.org ([2001:4830:134:3::10]:54087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzPNL-00015h-Fk
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 11:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzPNK-0002m1-NR
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 11:44:51 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:56362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dzPNK-0002l4-GH
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 11:44:50 -0400
Received: by mail-wr0-x22b.google.com with SMTP id r79so1309778wrb.13
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 08:44:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507032886-199950-1-git-send-email-imammedo@redhat.com>
References: <20171002192404.GC17385@localhost.localdomain>
	<1507032886-199950-1-git-send-email-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Oct 2017 16:44:28 +0100
Message-ID: <CAFEAcA8av+9qUDJ6U0YzOPxCx_xW4c-F+Ci1n+W=TxK909z1hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qom: add helpers REGISTER_STATIC_TYPE[S]()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On 3 October 2017 at 13:14, Igor Mammedov <imammedo@redhat.com> wrote:
> it will help to remove code duplication in places
> that currently open code registration of static
> type[s] and remove necessity to declare function
> for type_init() to call, when only static types
> need to be registered.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> I'm going to use it for CPU types in followup patches
>
> CC: ehabkost@redhat.com
> ---
>  include/qemu/module.h | 10 ++++++++++
>  include/qom/object.h  | 10 ++++++++++
>  qom/object.c          |  9 +++++++++
>  3 files changed, 29 insertions(+)
>
> diff --git a/include/qemu/module.h b/include/qemu/module.h
> index 56dd218..60dd632 100644
> --- a/include/qemu/module.h
> +++ b/include/qemu/module.h
> @@ -52,6 +52,16 @@ typedef enum {
>  #define type_init(function) module_init(function, MODULE_INIT_QOM)
>  #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
>
> +#define REGISTER_STATIC_TYPES(t, nr)                                        \
> +static void do_qemu_init_ ## t(void)                                        \
> +{                                                                           \
> +    type_register_static_array(t, nr);                                      \
> +}                                                                           \
> +type_init(do_qemu_init_ ## t)

Could we use
    type_register_static_array(t, ARRAY_SIZE(t));
here to save the caller having to pass the array size,
or is that too magic?

thanks
-- PMM
