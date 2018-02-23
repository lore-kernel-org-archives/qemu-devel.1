Received: from eggs.gnu.org ([2001:4830:134:3::10]:37467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHAi-0003Zx-RZ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHAd-0000tY-UI
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:30:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39778 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1epHAd-0000sv-P6
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:30:07 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-15-armbru@redhat.com>
	<151899673594.12376.17437330615460644069@sif>
Date: Fri, 23 Feb 2018 18:29:58 +0100
In-Reply-To: <151899673594.12376.17437330615460644069@sif> (Michael Roth's
	message of "Sun, 18 Feb 2018 17:32:15 -0600")
Message-ID: <871shblill.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/29] qapi: Concentrate
 QAPISchemaParser.exprs updates in .__init__()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

Michael Roth <mdroth@linux.vnet.ibm.com> writes:

> Quoting Markus Armbruster (2018-02-11 03:35:52)
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi/common.py | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index dce289ae21..cc5a5941dd 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -290,8 +290,12 @@ class QAPISchemaParser(object):
>>                  if not isinstance(include, str):
>>                      raise QAPISemError(info,
>>                                         "Value of 'include' must be a st=
ring")
>> -                self._include(include, info, os.path.dirname(self.fname=
),
>> -                              previously_included)
>> +                exprs_include =3D self._include(include, info,
>> +                                              os.path.dirname(self.fnam=
e),
>> +                                              previously_included)
>> +                if exprs_include:
>> +                    self.exprs.extend(exprs_include.exprs)
>> +                    self.docs.extend(exprs_include.docs)
>>              elif "pragma" in expr:
>>                  self.reject_expr_doc(cur_doc)
>>                  if len(expr) !=3D 1:
>> @@ -334,14 +338,13 @@ class QAPISchemaParser(object):
>>=20
>>          # skip multiple include of the same file
>>          if incl_abs_fname in previously_included:
>> -            return
>> +            return None
>> +
>>          try:
>>              fobj =3D open(incl_fname, 'r')
>>          except IOError as e:
>>              raise QAPISemError(info, '%s: %s' % (e.strerror, incl_fname=
))
>> -        exprs_include =3D QAPISchemaParser(fobj, previously_included, i=
nfo)
>> -        self.exprs.extend(exprs_include.exprs)
>> -        self.docs.extend(exprs_include.docs)
>
> minor nit, but the function of _include() seems more appropriately
> described now as _parse_include() or _parse_if_new() or something similar.

I'm open to renaming, but "parse" doesn't really fit.  _include()'s
caller checks syntax, then calls _include() to check semantic
constraints and evaluate the include, then splices in the evaluated
result.

> Maybe it would be more readable to just move the previously_included
> checks into init() and just drop _include() entirely?

Maybe.  But the conditional gets rather long then.

> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Thanks!
