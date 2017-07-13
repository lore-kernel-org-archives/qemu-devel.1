Received: from eggs.gnu.org ([2001:4830:134:3::10]:52101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVf4z-0002Po-Sm
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVf4z-0004cA-0V
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:57 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVf4y-0004bj-Qe
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:56 -0400
Received: by mail-wr0-x235.google.com with SMTP id r103so54053359wrb.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:26:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87lgns2zps.fsf@dusky.pond.sub.org>
References: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
	<1499788408-10096-2-git-send-email-peter.maydell@linaro.org>
	<87lgns2zps.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 15:26:35 +0100
Message-ID: <CAFEAcA--qraHck1_ba9ZFbZU+N-3FMzY8Z5rpri-NKr6K-dUmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 13 July 2017 at 15:11, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> In DEFINE_PROP_ARRAY, because we use a PropertyInfo (qdev_prop_arraylen)
>> which has a .set_default_value member we will set the field to a default
>> value. That default value will be zero, by the C rule that struct
>> initialization sets unmentioned members to zero if at least one member
>> is initialized. However it's clearer to state it explicitly.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> If my eyeball of the sources is correct, this is the only case we
>> have of a Property struct that uses a PropertyInfo with a non-NULL
>> .set_default_value but which doesn't explicitly set .defval.u.
>> ---
>>  include/hw/qdev-properties.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
>> index 0604c33..36d040c 100644
>> --- a/include/hw/qdev-properties.h
>> +++ b/include/hw/qdev-properties.h
>> @@ -110,6 +110,7 @@ extern PropertyInfo qdev_prop_arraylen;
>>                            _arrayfield, _arrayprop, _arraytype) {        \
>>          .name = (PROP_ARRAY_LEN_PREFIX _name),                          \
>>          .info = &(qdev_prop_arraylen),                                  \
>> +        .defval.u = 0,                                                  \
>>          .offset = offsetof(_state, _field)                              \
>>              + type_check(uint32_t, typeof_field(_state, _field)),       \
>>          .arrayinfo = &(_arrayprop),                                     \
>
> Hmm.
>
> .info and .defval apply to the array *length*.
> .info.set_default_value() is set_default_uint(), which uses .defval.u.
> Setting it here is correct.
>
> The array *elements* are described by .arrayinfo.  There is no
> .arraydefval, but that's okay, because .arrayinfo.set_default_value()
> doesn't get called.  Correct?

Correct. (There's no way to specify a default value for array properties.)

thanks
-- PMM
