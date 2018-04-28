Received: from eggs.gnu.org ([2001:4830:134:3::10]:35048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fCF1z-0003e5-Lz
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 21:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fCF1v-0004GD-P0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 21:52:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fCF1v-0004Fa-Iu
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 21:52:03 -0400
References: <1520219524-17160-1-git-send-email-jasowang@redhat.com>
	<1520219524-17160-8-git-send-email-jasowang@redhat.com>
	<CAFEAcA9UKGD6rziW=MVsJSgXvF10eTgTHd87qUwL9+aEKAy2zw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0125c397-4c62-0aa3-0bc1-1fd83c6f6401@redhat.com>
Date: Sat, 28 Apr 2018 09:51:55 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9UKGD6rziW=MVsJSgXvF10eTgTHd87qUwL9+aEKAy2zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 2018=E5=B9=B404=E6=9C=8827=E6=97=A5 20:29, Peter Maydell wrote:
> On 5 March 2018 at 03:12, Jason Wang <jasowang@redhat.com> wrote:
>> From: Thomas Huth <thuth@redhat.com>
> Hi. Coverity (CID 1390615) points out that we leak memory
> in an error-exit codepath in this function.
>
>> +/* For the convenience "--nic" parameter */
>> +static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
>> +{
>> +    char *mac, *nd_id;
>> +    int idx, ret;
>> +    NICInfo *ni;
>> +    const char *type;
>> +
>> +    type =3D qemu_opt_get(opts, "type");
>> +    if (type && g_str_equal(type, "none")) {
>> +        return 0;    /* Nothing to do, default_net is cleared in vl.c=
 */
>> +    }
>> +
>> +    idx =3D nic_get_free_idx();
>> +    if (idx =3D=3D -1 || nb_nics >=3D MAX_NICS) {
>> +        error_setg(errp, "no more on-board/default NIC slots availabl=
e");
>> +        return -1;
>> +    }
>> +
>> +    if (!type) {
>> +        qemu_opt_set(opts, "type", "user", &error_abort);
>> +    }
>> +
>> +    ni =3D &nd_table[idx];
>> +    memset(ni, 0, sizeof(*ni));
>> +    ni->model =3D qemu_opt_get_del(opts, "model");
>> +
>> +    /* Create an ID if the user did not specify one */
>> +    nd_id =3D g_strdup(qemu_opts_id(opts));
>> +    if (!nd_id) {
>> +        nd_id =3D g_strdup_printf("__org.qemu.nic%i\n", idx);
>> +        qemu_opts_set_id(opts, nd_id);
>> +    }
> Here we allocate nd_id...
>
>> +
>> +    /* Handle MAC address */
>> +    mac =3D qemu_opt_get_del(opts, "mac");
>> +    if (mac) {
>> +        ret =3D net_parse_macaddr(ni->macaddr.a, mac);
>> +        g_free(mac);
>> +        if (ret) {
>> +            error_setg(errp, "invalid syntax for ethernet address");
>> +            return -1;
>> +        }
>> +        if (is_multicast_ether_addr(ni->macaddr.a)) {
>> +            error_setg(errp, "NIC cannot have multicast MAC address")=
;
>> +            return -1;
>> +        }
> ...but in these two error-exit paths we do not free nd_id.
>
>> +    }
>> +    qemu_macaddr_default_if_unset(&ni->macaddr);
>> +
>> +    ret =3D net_client_init(opts, true, errp);
>> +    if (ret =3D=3D 0) {
>> +        ni->netdev =3D qemu_find_netdev(nd_id);
>> +        ni->used =3D true;
>> +        nb_nics++;
>> +    }
> Putting a label "out:" here and replacing the 'return -1's
> with "ret =3D -1; goto out;" would fix this.
>
>> +    g_free(nd_id);
>> +    return ret;
>> +}
>> +
> thanks
> -- PMM
>

Thanks Peter.

Thomas, want to send a fix for this?
