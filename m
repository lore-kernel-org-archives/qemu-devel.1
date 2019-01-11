Received: from eggs.gnu.org ([209.51.188.92]:55319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1ghy57-0003nW-T3
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1ghy56-0002KN-Fp
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:46:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ghy56-0002IS-9O
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:46:44 -0500
References: <20190108123311.24456-1-anthony.perard@citrix.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <4de1c9d8-0409-8d79-8839-7ce05e71eff2@redhat.com>
Date: Fri, 11 Jan 2019 09:37:47 -0500
MIME-Version: 1.0
In-Reply-To: <20190108123311.24456-1-anthony.perard@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qmp-shell: Fix example with objects as
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>



On 1/8/19 7:33 AM, Anthony PERARD wrote:
> The example shown that is suppose to let a user passes an object/array as
> argument doesn't work. The quotes get removed by shlex.split() and then
> both JSON parser complains. Fix the example by adding quotes and add
> examples with boolean and array.
> 
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>  scripts/qmp/qmp-shell | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> index 770140772d..9937e3c888 100755
> --- a/scripts/qmp/qmp-shell
> +++ b/scripts/qmp/qmp-shell
> @@ -33,7 +33,11 @@
>  # key=value pairs also support Python or JSON object literal subset notations,
>  # without spaces. Dictionaries/objects {} are supported as are arrays [].
>  #
> -#    example-command arg-name1={'key':'value','obj'={'prop':"value"}}

Yes, I can replicate that with a command such as:

(QEMU) object-add qom-type="rng-random" id="rng1" props={"filename":
"/dev/hwrng"}

That results in:

Error while parsing command line: Expected a key=value pair, got
'/dev/hwrng}'
command format: <command-name>  [arg-name1=arg1] ... [arg-nameN=argN]

> +#  JSON:
> +#    example-command arg-name1='{"key":"value","obj":{"prop":"value"}}'
> +#    example-command arg-name1='{"key":"value","obj":[1,true,"three"]}'

The usage fix is to have the dictionary quoted, indeed:

(QEMU) object-add qom-type="rng-random" id="rng4" props="{'filename':
'/dev/hwrng'}"
{"return": {}}

> +#  free style:
> +#    example-command arg-name1="{'key':'value',\"obj\":[1,True,\"three\"]}"
I just find the "free style" confusing... IMO how to be more creative
about escaping is optional, and adds noise to the most common use case.

Thanks,
- Cleber.

>  #
>  # Both JSON and Python formatting should work, including both styles of
>  # string literal quotes. Both paradigms of literal values should work,
> 

-- 
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
