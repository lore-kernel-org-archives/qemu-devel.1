Received: from eggs.gnu.org ([2001:4830:134:3::10]:47798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRi6O-00032c-W2
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRi6L-0001TM-Qr
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:28:52 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gRi6L-0001ST-Gr
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:28:49 -0500
Received: by mail-wm1-x343.google.com with SMTP id y1so21089wmi.3
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 10:28:49 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-48-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-48-cota@braap.org>
Date: Tue, 27 Nov 2018 18:28:46 +0000
Message-ID: <87d0qq4boh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 47/48] plugin: support guest hooks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> These "hooks" are callbacks from the guest to plugins. This is
> useful when we need guest-host communication, for instance to
> signal the beginning/end of a certain "region of interest" in
> the guest program. Simulators typically would use "magic"
> instructions for this, but that is painful to maintain across
> ISAs. Instead, we use plugin-chan PCI device through which we can
> relay guest messages to the host.

I suspect the solution for this is either a virtio socket that may (or
may not) be located on a PCI bus. However definitely out of scope for a
first cut of the plugin API, especially without an example usage.

Android has a similar guest-aware channel although the host side was
outside of QEMU and QEMU's part was just to expose a socket on the host
side that adb could talk to.

>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qemu/plugin-api.h |  6 ++++++
>  include/qemu/plugin.h     |  2 ++
>  plugin.c                  | 13 +++++++++++++
>  qemu-plugins.symbols      |  1 +
>  4 files changed, 22 insertions(+)
>
> diff --git a/include/qemu/plugin-api.h b/include/qemu/plugin-api.h
> index 5062e20e08..a5faff6a2a 100644
> --- a/include/qemu/plugin-api.h
> +++ b/include/qemu/plugin-api.h
> @@ -234,6 +234,12 @@ void qemu_plugin_register_lockstep_cb(qemu_plugin_id=
_t id,
>
>  void qemu_plugin_end_time_slice(void);
>
> +typedef void (*qemu_plugin_hook_cb_t)(uint32_t cmd, const void *data,
> +                                      size_t size);
> +
> +void qemu_plugin_register_hook_cb(qemu_plugin_id_t id,
> +                                  qemu_plugin_hook_cb_t cb);
> +
>  /* returns -1 in user-mode */
>  int qemu_plugin_n_vcpus(void);
>
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index f3c18d1032..ced265a127 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -61,12 +61,14 @@ enum qemu_plugin_event {
>      QEMU_PLUGIN_EV_LOCKSTEP,
>      QEMU_PLUGIN_EV_FLUSH,
>      QEMU_PLUGIN_EV_ATEXIT,
> +    QEMU_PLUGIN_EV_HOOK,
>      QEMU_PLUGIN_EV_MAX,
>  };
>
>  union qemu_plugin_cb_sig {
>      qemu_plugin_simple_cb_t          simple;
>      qemu_plugin_udata_cb_t           udata;
> +    qemu_plugin_hook_cb_t            hook;
>      qemu_plugin_vcpu_simple_cb_t     vcpu_simple;
>      qemu_plugin_vcpu_udata_cb_t      vcpu_udata;
>      qemu_plugin_vcpu_tb_trans_cb_t   vcpu_tb_trans;
> diff --git a/plugin.c b/plugin.c
> index 2bbc14e2f3..4004451bdb 100644
> --- a/plugin.c
> +++ b/plugin.c
> @@ -1078,8 +1078,21 @@ void plugin_lockstep_cb(void)
>      plugin_cb__simple(QEMU_PLUGIN_EV_LOCKSTEP);
>  }
>
> +void qemu_plugin_register_hook_cb(qemu_plugin_id_t id, qemu_plugin_hook_=
cb_t cb)
> +{
> +    plugin_register_cb(id, QEMU_PLUGIN_EV_HOOK, cb);
> +}
> +
>  void plugin_chan_xmit(uint32_t cmd, const void *data, size_t size)
>  {
> +    struct qemu_plugin_cb *cb, *next;
> +    enum qemu_plugin_event ev =3D QEMU_PLUGIN_EV_HOOK;
> +
> +    QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
> +        qemu_plugin_hook_cb_t func =3D cb->f.hook;
> +
> +        func(cmd, data, size);
> +    }
>  }
>
>  static void __attribute__((__constructor__)) plugin_init(void)
> diff --git a/qemu-plugins.symbols b/qemu-plugins.symbols
> index a3268a40c7..2e17693da8 100644
> --- a/qemu-plugins.symbols
> +++ b/qemu-plugins.symbols
> @@ -31,6 +31,7 @@
>    qemu_plugin_mem_is_big_endian;
>    qemu_plugin_mem_is_store;
>    qemu_plugin_vcpu_for_each;
> +  qemu_plugin_register_hook_cb;
>    qemu_plugin_n_vcpus;
>    qemu_plugin_n_max_vcpus;
>  };


--
Alex Benn=C3=A9e
