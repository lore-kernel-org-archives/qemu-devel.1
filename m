Received: from eggs.gnu.org ([209.51.188.92]:52915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj6HM-0003ei-7P
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj6HI-0006n8-GW
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:44:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gj6HG-0006gq-3Y
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:43:58 -0500
Date: Mon, 14 Jan 2019 15:43:44 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190114174344.GX4500@habkost.net>
References: <20190108123311.24456-1-anthony.perard@citrix.com>
	<4de1c9d8-0409-8d79-8839-7ce05e71eff2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4de1c9d8-0409-8d79-8839-7ce05e71eff2@redhat.com>
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
To: Cleber Rosa <crosa@redhat.com>
Cc: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

On Fri, Jan 11, 2019 at 09:37:47AM -0500, Cleber Rosa wrote:
> 
> 
> On 1/8/19 7:33 AM, Anthony PERARD wrote:
> > The example shown that is suppose to let a user passes an object/array as
> > argument doesn't work. The quotes get removed by shlex.split() and then
> > both JSON parser complains. Fix the example by adding quotes and add
> > examples with boolean and array.
> > 
> > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> > ---
> >  scripts/qmp/qmp-shell | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> > index 770140772d..9937e3c888 100755
> > --- a/scripts/qmp/qmp-shell
> > +++ b/scripts/qmp/qmp-shell
> > @@ -33,7 +33,11 @@
> >  # key=value pairs also support Python or JSON object literal subset notations,
> >  # without spaces. Dictionaries/objects {} are supported as are arrays [].

The "without spaces" part is outdated.  Now we do support spaces as long as the
argument is quoted.

> >  #
> > -#    example-command arg-name1={'key':'value','obj'={'prop':"value"}}
> 
> Yes, I can replicate that with a command such as:
> 
> (QEMU) object-add qom-type="rng-random" id="rng1" props={"filename":
> "/dev/hwrng"}
> 
> That results in:
> 
> Error while parsing command line: Expected a key=value pair, got
> '/dev/hwrng}'
> command format: <command-name>  [arg-name1=arg1] ... [arg-nameN=argN]

The example has no spaces, and you seem to have a whitespace
before "/dev/rng" above.

The problem here is that this worked before started using shlex.
qmp-shell from QEMU 3.0 worked:

  (QEMU) object-add qom-type=rng-random id="rng1" props={"filename":"/dev/hwrng"}
  {"return": {}}

Now we get this:

  (QEMU) object-add qom-type=rng-random id="rng1" props={"filename":"/dev/hwrng"}
  {"error": {"class": "GenericError", "desc": "Invalid parameter type for 'props', expected: dict"}}

This means we lost the ability to write JSON without any extra
quotes to gain the ability to have arguments with spaces.  How
hard it would be to fix that?


> 
> > +#  JSON:
> > +#    example-command arg-name1='{"key":"value","obj":{"prop":"value"}}'
> > +#    example-command arg-name1='{"key":"value","obj":[1,true,"three"]}'
> 
> The usage fix is to have the dictionary quoted, indeed:
> 
> (QEMU) object-add qom-type="rng-random" id="rng4" props="{'filename':
> '/dev/hwrng'}"
> {"return": {}}
> 
> > +#  free style:
> > +#    example-command arg-name1="{'key':'value',\"obj\":[1,True,\"three\"]}"
> I just find the "free style" confusing... IMO how to be more creative
> about escaping is optional, and adds noise to the most common use case.

The example seems to be a simple demonstration of how escaping
works, but maybe we shouldn't encourage people to try weird
tricks with escaping.  Especially if we want to eventually make
unquoted JSON data work again.

-- 
Eduardo
