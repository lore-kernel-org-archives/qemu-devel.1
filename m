Received: from eggs.gnu.org ([2001:4830:134:3::10]:44803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2VN-0000AJ-TK
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2VM-0005Qh-Vh
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:29:37 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:44423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC2VM-0005QK-RF
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:29:36 -0400
Received: by mail-oi0-x244.google.com with SMTP id e80-v6so1395796oig.11
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 05:29:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1520219524-17160-8-git-send-email-jasowang@redhat.com>
References: <1520219524-17160-1-git-send-email-jasowang@redhat.com>
	<1520219524-17160-8-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 13:29:15 +0100
Message-ID: <CAFEAcA9UKGD6rziW=MVsJSgXvF10eTgTHd87qUwL9+aEKAy2zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 7/9] net: Add a new convenience option
 "--nic" to configure default/on-board NICs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

On 5 March 2018 at 03:12, Jason Wang <jasowang@redhat.com> wrote:
> From: Thomas Huth <thuth@redhat.com>

Hi. Coverity (CID 1390615) points out that we leak memory
in an error-exit codepath in this function.

> +/* For the convenience "--nic" parameter */
> +static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
> +{
> +    char *mac, *nd_id;
> +    int idx, ret;
> +    NICInfo *ni;
> +    const char *type;
> +
> +    type = qemu_opt_get(opts, "type");
> +    if (type && g_str_equal(type, "none")) {
> +        return 0;    /* Nothing to do, default_net is cleared in vl.c */
> +    }
> +
> +    idx = nic_get_free_idx();
> +    if (idx == -1 || nb_nics >= MAX_NICS) {
> +        error_setg(errp, "no more on-board/default NIC slots available");
> +        return -1;
> +    }
> +
> +    if (!type) {
> +        qemu_opt_set(opts, "type", "user", &error_abort);
> +    }
> +
> +    ni = &nd_table[idx];
> +    memset(ni, 0, sizeof(*ni));
> +    ni->model = qemu_opt_get_del(opts, "model");
> +
> +    /* Create an ID if the user did not specify one */
> +    nd_id = g_strdup(qemu_opts_id(opts));
> +    if (!nd_id) {
> +        nd_id = g_strdup_printf("__org.qemu.nic%i\n", idx);
> +        qemu_opts_set_id(opts, nd_id);
> +    }

Here we allocate nd_id...

> +
> +    /* Handle MAC address */
> +    mac = qemu_opt_get_del(opts, "mac");
> +    if (mac) {
> +        ret = net_parse_macaddr(ni->macaddr.a, mac);
> +        g_free(mac);
> +        if (ret) {
> +            error_setg(errp, "invalid syntax for ethernet address");
> +            return -1;
> +        }
> +        if (is_multicast_ether_addr(ni->macaddr.a)) {
> +            error_setg(errp, "NIC cannot have multicast MAC address");
> +            return -1;
> +        }

...but in these two error-exit paths we do not free nd_id.

> +    }
> +    qemu_macaddr_default_if_unset(&ni->macaddr);
> +
> +    ret = net_client_init(opts, true, errp);
> +    if (ret == 0) {
> +        ni->netdev = qemu_find_netdev(nd_id);
> +        ni->used = true;
> +        nb_nics++;
> +    }

Putting a label "out:" here and replacing the 'return -1's
with "ret = -1; goto out;" would fix this.

> +    g_free(nd_id);
> +    return ret;
> +}
> +

thanks
-- PMM
