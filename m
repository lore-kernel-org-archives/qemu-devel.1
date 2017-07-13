Received: from eggs.gnu.org ([2001:4830:134:3::10]:43985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVeqi-0001YZ-Hh
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVeqh-00028P-G5
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:12:12 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
	<1499788408-10096-2-git-send-email-peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 16:11:59 +0200
In-Reply-To: <1499788408-10096-2-git-send-email-peter.maydell@linaro.org>
	(Peter Maydell's message of "Tue, 11 Jul 2017 16:53:26 +0100")
Message-ID: <87lgns2zps.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/3] qdev-properties.h: Explicitly set the
 default value for arraylen properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr?= =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@redhat.com>, patches@linaro.org

Peter Maydell <peter.maydell@linaro.org> writes:

> In DEFINE_PROP_ARRAY, because we use a PropertyInfo (qdev_prop_arraylen)
> which has a .set_default_value member we will set the field to a default
> value. That default value will be zero, by the C rule that struct
> initialization sets unmentioned members to zero if at least one member
> is initialized. However it's clearer to state it explicitly.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> If my eyeball of the sources is correct, this is the only case we
> have of a Property struct that uses a PropertyInfo with a non-NULL
> .set_default_value but which doesn't explicitly set .defval.u.
> ---
>  include/hw/qdev-properties.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 0604c33..36d040c 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -110,6 +110,7 @@ extern PropertyInfo qdev_prop_arraylen;
>                            _arrayfield, _arrayprop, _arraytype) {        \
>          .name = (PROP_ARRAY_LEN_PREFIX _name),                          \
>          .info = &(qdev_prop_arraylen),                                  \
> +        .defval.u = 0,                                                  \
>          .offset = offsetof(_state, _field)                              \
>              + type_check(uint32_t, typeof_field(_state, _field)),       \
>          .arrayinfo = &(_arrayprop),                                     \

Hmm.

.info and .defval apply to the array *length*.
.info.set_default_value() is set_default_uint(), which uses .defval.u.
Setting it here is correct.

The array *elements* are described by .arrayinfo.  There is no
.arraydefval, but that's okay, because .arrayinfo.set_default_value()
doesn't get called.  Correct?
