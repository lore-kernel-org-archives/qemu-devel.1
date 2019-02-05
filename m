Received: from eggs.gnu.org ([209.51.188.92]:44725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr0V0-0002sN-Kz
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr0Tn-0004ip-JA
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:09:36 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr0Tn-0004es-Ee
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:09:35 -0500
Received: by mail-ot1-x343.google.com with SMTP id s13so5535445otq.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 05:09:23 -0800 (PST)
MIME-Version: 1.0
References: <1549371525-29899-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1549371525-29899-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 13:09:10 +0000
Message-ID: <CAFEAcA9PKSW92GJO1KcBEQcbGY7TB4pqaW8qSe9j6JJZ7Z2MKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/cpu/cluster: Mark the cpu-cluster
 device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Luc Michel <luc.michel@greensocs.com>, Alistair Francis <alistair.francis@wdc.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On Tue, 5 Feb 2019 at 12:58, Thomas Huth <thuth@redhat.com> wrote:
>
> The device can not be instantiated by the user and QEMU currently
> aborts when you try to use it:
>
> $ x86_64-softmmu/qemu-system-x86_64 -device cpu-cluster
> qemu-system-x86_64: hw/cpu/cluster.c:73: cpu_cluster_realize:
>  Assertion `cbdata.cpu_count > 0' failed.
> Aborted (core dumped)
>
> Since this is an internal device only, mark it with user_creatable = false.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/cpu/cluster.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
> index 25f9070..6f5f037 100644
> --- a/hw/cpu/cluster.c
> +++ b/hw/cpu/cluster.c
> @@ -79,6 +79,9 @@ static void cpu_cluster_class_init(ObjectClass *klass, void *data)
>
>      dc->props = cpu_cluster_properties;
>      dc->realize = cpu_cluster_realize;
> +
> +    /* This is not directly for users, CPU children must be attached by code */
> +    dc->user_creatable = false;
>  }
>
>  static const TypeInfo cpu_cluster_type_info = {
> --


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Would it be possible to add a 'make check' test that every device
we claim to be user-creatable can be created without crashing ?

thanks
-- PMM
