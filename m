Received: from eggs.gnu.org ([2001:4830:134:3::10]:53646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dO3ZF-0004C5-0e
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dO3ZD-0001Jn-7v
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:58:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170621134744.8047-1-mreitz@redhat.com>
	<20170621134744.8047-3-mreitz@redhat.com>
	<8760fpwatr.fsf@dusky.pond.sub.org>
	<665bddbf-39c4-0678-b82d-ad7dfa7f1a9e@redhat.com>
Date: Thu, 22 Jun 2017 16:58:33 +0200
In-Reply-To: <665bddbf-39c4-0678-b82d-ad7dfa7f1a9e@redhat.com> (Max Reitz's
	message of "Wed, 21 Jun 2017 23:47:46 +0200")
Message-ID: <87a850gjc6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> On 2017-06-21 18:43, Markus Armbruster wrote:
>> Max Reitz <mreitz@redhat.com> writes:
>> 
>>> This generic function (along with its implementations for different
>>> types) determines whether two QObjects are equal.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  include/qapi/qmp/qbool.h   |  1 +
>>>  include/qapi/qmp/qdict.h   |  1 +
>>>  include/qapi/qmp/qfloat.h  |  1 +
>>>  include/qapi/qmp/qint.h    |  1 +
>>>  include/qapi/qmp/qlist.h   |  1 +
>>>  include/qapi/qmp/qnull.h   |  2 ++
>>>  include/qapi/qmp/qobject.h |  9 +++++++++
>>>  include/qapi/qmp/qstring.h |  1 +
>>>  qobject/qbool.c            |  8 ++++++++
>>>  qobject/qdict.c            | 28 ++++++++++++++++++++++++++++
>>>  qobject/qfloat.c           |  8 ++++++++
>>>  qobject/qint.c             |  8 ++++++++
>>>  qobject/qlist.c            | 30 ++++++++++++++++++++++++++++++
>>>  qobject/qnull.c            |  5 +++++
>>>  qobject/qobject.c          | 30 ++++++++++++++++++++++++++++++
>>>  qobject/qstring.c          |  9 +++++++++
>>>  16 files changed, 143 insertions(+)
>> 
>> No unit test?
>
> *cough*
>
>>> diff --git a/include/qapi/qmp/qbool.h b/include/qapi/qmp/qbool.h
>>> index a41111c..f77ea86 100644
>>> --- a/include/qapi/qmp/qbool.h
>>> +++ b/include/qapi/qmp/qbool.h
>>> @@ -24,6 +24,7 @@ typedef struct QBool {
>>>  QBool *qbool_from_bool(bool value);
>>>  bool qbool_get_bool(const QBool *qb);
>>>  QBool *qobject_to_qbool(const QObject *obj);
>>> +bool qbool_is_equal(const QObject *x, const QObject *y);
>>>  void qbool_destroy_obj(QObject *obj);
>>>  
>>>  #endif /* QBOOL_H */
>>> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
>>> index 188440a..134a526 100644
>>> --- a/include/qapi/qmp/qdict.h
>>> +++ b/include/qapi/qmp/qdict.h
>>> @@ -41,6 +41,7 @@ void qdict_del(QDict *qdict, const char *key);
>>>  int qdict_haskey(const QDict *qdict, const char *key);
>>>  QObject *qdict_get(const QDict *qdict, const char *key);
>>>  QDict *qobject_to_qdict(const QObject *obj);
>>> +bool qdict_is_equal(const QObject *x, const QObject *y);
>>>  void qdict_iter(const QDict *qdict,
>>>                  void (*iter)(const char *key, QObject *obj, void *opaque),
>>>                  void *opaque);
>>> diff --git a/include/qapi/qmp/qfloat.h b/include/qapi/qmp/qfloat.h
>>> index b5d1583..318e91e 100644
>>> --- a/include/qapi/qmp/qfloat.h
>>> +++ b/include/qapi/qmp/qfloat.h
>>> @@ -24,6 +24,7 @@ typedef struct QFloat {
>>>  QFloat *qfloat_from_double(double value);
>>>  double qfloat_get_double(const QFloat *qi);
>>>  QFloat *qobject_to_qfloat(const QObject *obj);
>>> +bool qfloat_is_equal(const QObject *x, const QObject *y);
>>>  void qfloat_destroy_obj(QObject *obj);
>>>  
>>>  #endif /* QFLOAT_H */
>>> diff --git a/include/qapi/qmp/qint.h b/include/qapi/qmp/qint.h
>>> index 3aaff76..20975da 100644
>>> --- a/include/qapi/qmp/qint.h
>>> +++ b/include/qapi/qmp/qint.h
>>> @@ -23,6 +23,7 @@ typedef struct QInt {
>>>  QInt *qint_from_int(int64_t value);
>>>  int64_t qint_get_int(const QInt *qi);
>>>  QInt *qobject_to_qint(const QObject *obj);
>>> +bool qint_is_equal(const QObject *x, const QObject *y);
>>>  void qint_destroy_obj(QObject *obj);
>>>  
>>>  #endif /* QINT_H */
>>> diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
>>> index 5dc4ed9..4380a5b 100644
>>> --- a/include/qapi/qmp/qlist.h
>>> +++ b/include/qapi/qmp/qlist.h
>>> @@ -57,6 +57,7 @@ QObject *qlist_peek(QList *qlist);
>>>  int qlist_empty(const QList *qlist);
>>>  size_t qlist_size(const QList *qlist);
>>>  QList *qobject_to_qlist(const QObject *obj);
>>> +bool qlist_is_equal(const QObject *x, const QObject *y);
>>>  void qlist_destroy_obj(QObject *obj);
>>>  
>>>  static inline const QListEntry *qlist_first(const QList *qlist)
>>> diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
>>> index 69555ac..9299683 100644
>>> --- a/include/qapi/qmp/qnull.h
>>> +++ b/include/qapi/qmp/qnull.h
>>> @@ -23,4 +23,6 @@ static inline QObject *qnull(void)
>>>      return &qnull_;
>>>  }
>>>  
>>> +bool qnull_is_equal(const QObject *x, const QObject *y);
>>> +
>>>  #endif /* QNULL_H */
>>> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
>>> index ef1d1a9..cac72e3 100644
>>> --- a/include/qapi/qmp/qobject.h
>>> +++ b/include/qapi/qmp/qobject.h
>>> @@ -68,6 +68,15 @@ static inline void qobject_incref(QObject *obj)
>>>  }
>>>  
>>>  /**
>>> + * qobject_is_equal(): Returns whether the two objects are equal.
>> 
>> Imperative mood, please: Return whether...
>
> OK, will do here and everywhere else.
>
>>> + *
>>> + * Any of the pointers may be NULL; will return true if both are. Will always
>>> + * return false if only one is (therefore a QNull object is not considered equal
>>> + * to a NULL pointer).
>>> + */
>> 
>> Humor me: wrap comment lines around column 70, and put two spaces
>> between sentences.
>
> Do I hear "one checkpatch.pl per subsystem"?

Nah, you hear "would you mind doing me a favor if I ask nicely?"

> Yes, I know, there's no point to. Why should anyone not break comments
> after 70 lines and not use two spaces after full stops? O:-)

That too ;)

>> Same for the other function comments.
>
> Sure, will do.
>
>>> +bool qobject_is_equal(const QObject *x, const QObject *y);
>>> +
>>> +/**
>>>   * qobject_destroy(): Free resources used by the object
>>>   */
>>>  void qobject_destroy(QObject *obj);
>>> diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
>>> index 10076b7..65c05a9 100644
>>> --- a/include/qapi/qmp/qstring.h
>>> +++ b/include/qapi/qmp/qstring.h
>>> @@ -31,6 +31,7 @@ void qstring_append_int(QString *qstring, int64_t value);
>>>  void qstring_append(QString *qstring, const char *str);
>>>  void qstring_append_chr(QString *qstring, int c);
>>>  QString *qobject_to_qstring(const QObject *obj);
>>> +bool qstring_is_equal(const QObject *x, const QObject *y);
>>>  void qstring_destroy_obj(QObject *obj);
>>>  
>>>  #endif /* QSTRING_H */
>>> diff --git a/qobject/qbool.c b/qobject/qbool.c
>>> index 0606bbd..f1d1719 100644
>>> --- a/qobject/qbool.c
>>> +++ b/qobject/qbool.c
>>> @@ -52,6 +52,14 @@ QBool *qobject_to_qbool(const QObject *obj)
>>>  }
>>>  
>>>  /**
>>> + * qbool_is_equal(): Tests whether the two QBools are equal
>> 
>> Return whether ...
>> 
>>> + */
>>> +bool qbool_is_equal(const QObject *x, const QObject *y)
>>> +{
>>> +    return qobject_to_qbool(x)->value == qobject_to_qbool(y)->value;
>>> +}
>>> +
>>> +/**
>>>   * qbool_destroy_obj(): Free all memory allocated by a
>>>   * QBool object
>>>   */
>>> diff --git a/qobject/qdict.c b/qobject/qdict.c
>>> index 88e2ecd..ca919bc 100644
>>> --- a/qobject/qdict.c
>>> +++ b/qobject/qdict.c
>>> @@ -410,6 +410,34 @@ void qdict_del(QDict *qdict, const char *key)
>>>  }
>>>  
>>>  /**
>>> + * qdict_is_equal(): Tests whether the two QDicts are equal
>>> + *
>>> + * Here, equality means whether they contain the same keys and whether the
>>> + * respective values are in turn equal (i.e. invoking qobject_is_equal() on them
>>> + * yields true).
>>> + */
>>> +bool qdict_is_equal(const QObject *x, const QObject *y)
>>> +{
>>> +    const QDict *dict_x = qobject_to_qdict(x), *dict_y = qobject_to_qdict(y);
>> 
>> I'm fine with multiple initializers in one declaration, but I think this
>> one would look tidier as
>> 
>>        const QDict *dict_x = qobject_to_qdict(x);
>>        const QDict *dict_y = qobject_to_qdict(y);
>
> I don't mind.
>
>>> +    const QDictEntry *e;
>>> +
>>> +    if (qdict_size(dict_x) != qdict_size(dict_y)) {
>>> +        return false;
>>> +    }
>>> +
>>> +    for (e = qdict_first(dict_x); e; e = qdict_next(dict_x, e)) {
>>> +        const QObject *obj_x = qdict_entry_value(e);
>>> +        const QObject *obj_y = qdict_get(dict_y, qdict_entry_key(e));
>>> +
>>> +        if (!qobject_is_equal(obj_x, obj_y)) {
>>> +            return false;
>>> +        }
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +/**
>>>   * qdict_destroy_obj(): Free all the memory allocated by a QDict
>>>   */
>>>  void qdict_destroy_obj(QObject *obj)
>>> diff --git a/qobject/qfloat.c b/qobject/qfloat.c
>>> index d5da847..291ecc4 100644
>>> --- a/qobject/qfloat.c
>>> +++ b/qobject/qfloat.c
>>> @@ -52,6 +52,14 @@ QFloat *qobject_to_qfloat(const QObject *obj)
>>>  }
>>>  
>>>  /**
>>> + * qfloat_is_equal(): Tests whether the two QFloats are equal
>>> + */
>>> +bool qfloat_is_equal(const QObject *x, const QObject *y)
>>> +{
>>> +    return qobject_to_qfloat(x)->value == qobject_to_qfloat(y)->value;
>>> +}
>>> +
>>> +/**
>>>   * qfloat_destroy_obj(): Free all memory allocated by a
>>>   * QFloat object
>>>   */
>>> diff --git a/qobject/qint.c b/qobject/qint.c
>>> index d7d1b30..f638cb7 100644
>>> --- a/qobject/qint.c
>>> +++ b/qobject/qint.c
>>> @@ -51,6 +51,14 @@ QInt *qobject_to_qint(const QObject *obj)
>>>  }
>>>  
>>>  /**
>>> + * qint_is_equal(): Tests whether the two QInts are equal
>>> + */
>>> +bool qint_is_equal(const QObject *x, const QObject *y)
>>> +{
>>> +    return qobject_to_qint(x)->value == qobject_to_qint(y)->value;
>>> +}
>>> +
>>> +/**
>>>   * qint_destroy_obj(): Free all memory allocated by a
>>>   * QInt object
>>>   */
>>> diff --git a/qobject/qlist.c b/qobject/qlist.c
>>> index 86b60cb..652fc53 100644
>>> --- a/qobject/qlist.c
>>> +++ b/qobject/qlist.c
>>> @@ -140,6 +140,36 @@ QList *qobject_to_qlist(const QObject *obj)
>>>  }
>>>  
>>>  /**
>>> + * qlist_is_equal(): Tests whether the two QLists are equal
>>> + *
>>> + * In order to be considered equal, the respective two objects at each index of
>>> + * the two lists have to compare equal (regarding qobject_is_equal()), and both
>>> + * lists have to have the same number of elements.
>>> + * That means, both lists have to contain equal objects in equal order.
>>> + */
>>> +bool qlist_is_equal(const QObject *x, const QObject *y)
>>> +{
>>> +    const QList *list_x = qobject_to_qlist(x), *list_y = qobject_to_qlist(y);
>>> +    const QListEntry *entry_x, *entry_y;
>>> +
>>> +    entry_x = qlist_first(list_x);
>>> +    entry_y = qlist_first(list_y);
>>> +
>>> +    while (entry_x && entry_y) {
>>> +        if (!qobject_is_equal(qlist_entry_obj(entry_x),
>>> +                              qlist_entry_obj(entry_y)))
>>> +        {
>>> +            return false;
>>> +        }
>>> +
>>> +        entry_x = qlist_next(entry_x);
>>> +        entry_y = qlist_next(entry_y);
>>> +    }
>>> +
>>> +    return !entry_x && !entry_y;
>>> +}
>>> +
>>> +/**
>>>   * qlist_destroy_obj(): Free all the memory allocated by a QList
>>>   */
>>>  void qlist_destroy_obj(QObject *obj)
>>> diff --git a/qobject/qnull.c b/qobject/qnull.c
>>> index b3cc85e..af5453d 100644
>>> --- a/qobject/qnull.c
>>> +++ b/qobject/qnull.c
>>> @@ -19,3 +19,8 @@ QObject qnull_ = {
>>>      .type = QTYPE_QNULL,
>>>      .refcnt = 1,
>>>  };
>>> +
>>> +bool qnull_is_equal(const QObject *x, const QObject *y)
>>> +{
>>> +    return true;
>>> +}
>>> diff --git a/qobject/qobject.c b/qobject/qobject.c
>>> index fe4fa10..af2869a 100644
>>> --- a/qobject/qobject.c
>>> +++ b/qobject/qobject.c
>>> @@ -28,3 +28,33 @@ void qobject_destroy(QObject *obj)
>>>      assert(QTYPE_QNULL < obj->type && obj->type < QTYPE__MAX);
>>>      qdestroy[obj->type](obj);
>>>  }
>>> +
>>> +
>>> +static bool (*qis_equal[QTYPE__MAX])(const QObject *, const QObject *) = {
>>> +    [QTYPE_NONE] = NULL,               /* No such object exists */
>>> +    [QTYPE_QNULL] = qnull_is_equal,
>>> +    [QTYPE_QINT] = qint_is_equal,
>>> +    [QTYPE_QSTRING] = qstring_is_equal,
>>> +    [QTYPE_QDICT] = qdict_is_equal,
>>> +    [QTYPE_QLIST] = qlist_is_equal,
>>> +    [QTYPE_QFLOAT] = qfloat_is_equal,
>>> +    [QTYPE_QBOOL] = qbool_is_equal,
>>> +};
>>> +
>>> +bool qobject_is_equal(const QObject *x, const QObject *y)
>>> +{
>>> +    /* We cannot test x == y because an object does not need to be equal to
>>> +     * itself (e.g. NaN floats are not). */
>>> +
>>> +    if (!x && !y) {
>>> +        return true;
>>> +    }
>>> +
>>> +    if (!x || !y || x->type != y->type) {
>>> +        return false;
>>> +    }
>>> +
>>> +    assert(QTYPE_NONE < x->type && x->type < QTYPE__MAX);
>>> +
>>> +    return qis_equal[x->type](x, y);
>>> +}
>>> diff --git a/qobject/qstring.c b/qobject/qstring.c
>>> index 5da7b5f..a2b51fa 100644
>>> --- a/qobject/qstring.c
>>> +++ b/qobject/qstring.c
>>> @@ -129,6 +129,15 @@ const char *qstring_get_str(const QString *qstring)
>>>  }
>>>  
>>>  /**
>>> + * qstring_is_equal(): Tests whether the two QStrings are equal
>>> + */
>>> +bool qstring_is_equal(const QObject *x, const QObject *y)
>>> +{
>>> +    return !strcmp(qobject_to_qstring(x)->string,
>>> +                   qobject_to_qstring(y)->string);
>>> +}
>>> +
>>> +/**
>>>   * qstring_destroy_obj(): Free all memory allocated by a QString
>>>   * object
>>>   */
>> 
>> Address my nitpicks, and either provide a unit test or convince me it's
>> not worth the trouble, and you may add
>
> Unfortunately (for me), it's always worth the trouble.

Awesome!

>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Thanks again!
>
> Max
