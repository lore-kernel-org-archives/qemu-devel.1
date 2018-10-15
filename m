Received: from eggs.gnu.org ([2001:4830:134:3::10]:41283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6GW-0006xL-WA
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6GU-0004YE-9w
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:02:48 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC6GU-0004Xv-1N
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:02:46 -0400
Received: by mail-pl1-x642.google.com with SMTP id f18-v6so9613053plr.1
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 10:02:45 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <42d7b0ca-28a3-f97c-c295-5000416f256d@linaro.org>
Date: Mon, 15 Oct 2018 10:02:41 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 13/21] tracetool: generate plugin
 snippets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, cota@braap.org, vilanova@ac.upc.edu, Pavel.Dovgaluk@ispras.ru

On 10/5/18 8:49 AM, Alex Bennée wrote:
> +def generate_h_begin(events, group):
> +    for event in events:
> +        # prototype for plugin event
> +        out('bool _plugin_%(api)s(%(args)s);',
> +            api=event.api(),
> +            args=event.args)
> +        # prototype for plugin fn
> +        out("typedef bool (* _plugin_%(api)s_fn)(%(args)s);",
> +            api=event.api(),
> +            args=event.args)

Do you really want the _fn typedef to be a pointer?
Not doing that would allow declarations like

  _plugin_apis_fn _plugin_apis;


> +def generate_h(event, group):
> +    out('    if (!_plugin_%(api)s(%(args)s)) {',
> +        '        return;',
> +        '    };',

Extra ;

> +    # Forst the pre-amble, bail early if the event is not enabled and

First.

> +    # if it is but no plugin is enabled let the reset of the events proceed.
> +
> +    out('',
> +        '    if (!%(cond)s) {',
> +        '        return false;',
> +        '    }',
> +        '',
> +        '    uintptr_t fp = trace_event_get_plugin(&_%(event)s_EVENT);',

Declaration in the middle of a block.
Which, honestly, we should just allow via -std=gnu99 or gnu01.
But until then...

> +    out('',
> +        '    _plugin_%(api)s_fn plug_fn = (_plugin_%(api)s_fn) fp;',

Likewise.


r~
