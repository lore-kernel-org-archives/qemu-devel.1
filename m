Received: from eggs.gnu.org ([2001:4830:134:3::10]:38329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVgsL-0006Hp-Kf
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVgsK-0007J7-K8
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:22:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
	<1499788408-10096-2-git-send-email-peter.maydell@linaro.org>
	<87lgns2zps.fsf@dusky.pond.sub.org>
	<CAFEAcA--qraHck1_ba9ZFbZU+N-3FMzY8Z5rpri-NKr6K-dUmA@mail.gmail.com>
Date: Thu, 13 Jul 2017 18:21:50 +0200
In-Reply-To: <CAFEAcA--qraHck1_ba9ZFbZU+N-3FMzY8Z5rpri-NKr6K-dUmA@mail.gmail.com>
	(Peter Maydell's message of "Thu, 13 Jul 2017 15:26:35 +0100")
Message-ID: <87k23cxq75.fsf@dusky.pond.sub.org>
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 13 July 2017 at 15:11, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> In DEFINE_PROP_ARRAY, because we use a PropertyInfo (qdev_prop_arraylen)
>>> which has a .set_default_value member we will set the field to a default
>>> value. That default value will be zero, by the C rule that struct
>>> initialization sets unmentioned members to zero if at least one member
>>> is initialized. However it's clearer to state it explicitly.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> If my eyeball of the sources is correct, this is the only case we
>>> have of a Property struct that uses a PropertyInfo with a non-NULL
>>> .set_default_value but which doesn't explicitly set .defval.u.
>>> ---
>>>  include/hw/qdev-properties.h | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
>>> index 0604c33..36d040c 100644
>>> --- a/include/hw/qdev-properties.h
>>> +++ b/include/hw/qdev-properties.h
>>> @@ -110,6 +110,7 @@ extern PropertyInfo qdev_prop_arraylen;
>>>                            _arrayfield, _arrayprop, _arraytype) {        \
>>>          .name = (PROP_ARRAY_LEN_PREFIX _name),                          \
>>>          .info = &(qdev_prop_arraylen),                                  \
>>> +        .defval.u = 0,                                                  \
>>>          .offset = offsetof(_state, _field)                              \
>>>              + type_check(uint32_t, typeof_field(_state, _field)),       \
>>>          .arrayinfo = &(_arrayprop),                                     \
>>
>> Hmm.
>>
>> .info and .defval apply to the array *length*.
>> .info.set_default_value() is set_default_uint(), which uses .defval.u.
>> Setting it here is correct.
>>
>> The array *elements* are described by .arrayinfo.  There is no
>> .arraydefval, but that's okay, because .arrayinfo.set_default_value()
>> doesn't get called.  Correct?
>
> Correct. (There's no way to specify a default value for array properties.)

Thanks!

Reviewed-by: Markus Armbruster <armbru@redhat.com>
