Received: from eggs.gnu.org ([2001:4830:134:3::10]:36509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVGlO-0005BY-La
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVGlL-0002NL-Gu
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:29:06 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVGlL-0002L6-97
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:29:03 -0400
Received: by mail-wr0-f175.google.com with SMTP id 77so31741242wrb.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 05:29:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87lgnt99xz.fsf@dusky.pond.sub.org>
References: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
	<1499788408-10096-3-git-send-email-peter.maydell@linaro.org>
	<87lgnt99xz.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Jul 2017 13:27:39 +0100
Message-ID: <CAFEAcA8JmF+8MdCGYbVr9AYx+3ybXqGbLLzZiFgoQmJPHYTsZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/3] qdev: support properties which don't
 set a default value
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

On 12 July 2017 at 12:22, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> In some situations it's useful to have a qdev property which doesn't
>> automatically set its default value when qdev_property_add_static is
>> called (for instance when the default value is not constant).
>>
>> Support this by adding a flag to the Property struct indicating
>> whether to set the default value.  This replaces the existing test
>> for whether the PorpertyInfo set_default_value function pointer is
>
> PropertyInfo
>
>> NULL, and we set the .set_default field to true for all those cases
>> of struct Property which use a PropertyInfo with a non-NULL
>> set_default_value, so behaviour remains the same as before.
>>
>> We define two new macros DEFINE_PROP_SIGNED_NODEFAULT and
>> DEFINE_PROP_UNSIGNED_NODEFAULT, to cover the most plausible use cases
>> of wanting to set an integer property with no default value.
>
> Your text makes me wonder what is supposed to set the default value
> then.  Glancing ahead to PATCH 3, it looks like method instance_init()
> is.  Can you think of a scenario where something else sets it?

Yes, instance_init is the obvious place (though in fact pretty
much anything that runs before the user of the device sets
properties will do).

>>      union {
>>          int64_t i;
>>          uint64_t u;
>> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
>> index 36d040c..66816a5 100644
>> --- a/include/hw/qdev-properties.h
>> +++ b/include/hw/qdev-properties.h
>> @@ -43,15 +43,24 @@ extern PropertyInfo qdev_prop_arraylen;
>>          .info      = &(_prop),                                          \
>>          .offset    = offsetof(_state, _field)                           \
>>              + type_check(_type,typeof_field(_state, _field)),           \
>> +        .set_default = true,                                            \
>>          .defval.i  = (_type)_defval,                                    \
>>          }
>
> If you flip the sense of the flag, you don't need to mess with the
> PropertyInfo, and don't need the note referring reviewers to the
> previous patch.  However, the case "use .defval" already requires an
> initializer, so adding one for .set_default seems fair.  Okay.

Having the flag this way round was your idea :-)
Putting it the other way round might have been a smaller change
in some sense (you'd have had to retain the check on
set_default_value being NULL), but I do think it's nicer
in the end...

> Preferably with a suitable comment on member set_default and an improved
> commit message:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

thanks
-- PMM
